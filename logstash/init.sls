# Copyright 2013 Hewlett-Packard Development Company, L.P.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#

#
# There are 3 supported methods for getting the logstash jar on disk:
# deb/apt: install a package that will drop the jar on disk, assume the repo
#           is already configured
#
# http:     grab the jar over http, defaults to the public download, override
#           via the logstash:jar_source & logstash:jar_hash pillar
#
# deb/http: pull a .deb over http & install, this will drop the jar on disk
#
{% set jar_delivery = salt['pillar.get']('logstash:jar_delivery', 'deb/apt') %}

{% if jar_delivery == 'deb/apt' %}
logstash_jar:
  pkg:
    - latest
    - name: logstash
{% endif %}

{% if jar_delivery == 'http' %}
logstash_jar:
  file:
    - managed
    - source: {{ salt['pillar.get']('logstash:jar_source', 'https://download.elasticsearch.org/logstash/logstash/logstash-1.2.1-flatjar.jar') }}
    - source_hash: {{ salt['pillar.get']('logstash:jar_hash', 'md5=863272192b52bccf1fc2cf839a888eaf') }}
    - name: /opt/logstash/logstash.jar
    - user: root
    - group: root
    - mode: 664
    - require:
      - file: /opt/logstash
{% endif %}

{% if jar_delivery == 'deb/http' %}
# Pull a specific .deb from a location you set in the pillar
# (we default to keg in uswest)
logstash_jar:
  pkg.installed:
    - name: logstash
    - sources:
      - logstash: {{ salt['pillar.get']('logstash:deb_source', 'http://keg.dev.uswest.hpcloud.net/cloud/paas-deploy/developer/pool/release/l/logstash/logstash_1.2.1_all.deb') }}
{% endif %}

logstash-jre:
  pkg:
    - installed
    - name: openjdk-7-jre-headless

/etc/logstash:
  file:
    - directory
    - user: root
    - group: root

/etc/logstash/patterns:
  file:
    - recurse
    - user: root
    - group: root
    - source: salt://logstash/files/patterns
    - require:
      - file: /etc/logstash

/etc/logstash/conf.d:
  file:
    - recurse
    - user: root
    - group: root
    - source: salt://logstash/files/conf.d
    - require:
      - file: /etc/logstash

/var/log/logstash:
  file:
    - directory
    - user: logstash
    - group: adm
    - require:
      - user: logstash

/opt/logstash:
  file:
    - directory
    - makedirs: True
    - user: logstash
    - group: adm
    - require:
      - user: logstash

/etc/logstash/conf.d/inputs.conf:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://logstash/templates/inputs.conf.jinja
    - require:
      - file: /etc/logstash/conf.d

/etc/logstash/conf.d/common.conf:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://logstash/templates/common.conf.jinja
    - require:
      - file: /etc/logstash/conf.d

/etc/logstash/conf.d/outputs.conf:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://logstash/templates/outputs.conf.jinja
    - require:
      - file: /etc/logstash/conf.d

/etc/init/logstash.conf:
  file:
    - managed
    - source: salt://logstash/files/logstash.upstart

/etc/init.d/logstash:
  file:
    - symlink
    - target: /lib/init/upstart-job
    - require:
      - file: /etc/init/logstash.conf

/etc/logrotate.d/logstash:
  file:
    - managed
    - source: salt://logstash/files/logstash.logrotate

# if we have an SSL cert&key, drop it in place
{% set ssl_cert = salt['pillar.get']('logstash:ssl_cert', False) %}
{% if ssl_cert %}
/etc/logstash/logstash.crt:
  file:
    - managed
    - contents_pillar: logstash:ssl_cert
    - require:
      - file: /opt/logstash
{% endif %}

{% set ssl_key = salt['pillar.get']('logstash:ssl_key', False) %}
{% if ssl_key %}
/etc/logstash/logstash.key:
  file:
    - managed
    - contents_pillar: logstash:ssl_key
    - require:
      - file: /opt/logstash
{% endif %}

# HPCS CA Cert
/etc/logstash/hpcs_ca.pem:
  file:
    - managed
    - source: salt://logstash/files/hpcs_ca.pem
    - require:
      - file: /opt/logstash

logstash:
  service:
    - running
    - watch:
      - file: /etc/init/logstash.conf
      - file: /etc/logstash/conf.d
    - require:
      - user: logstash
      - pkg: logstash-jre
      - file: /var/log/logstash
    # can't require logstash_jar as its state may be either file or pkg
    - order: last
  user:
    - present
    - fullname: Logstash
    - home: /opt/logstash
    - system: true
