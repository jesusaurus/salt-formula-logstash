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

/etc/logstash/logstash.conf:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://logstash/templates/logstash.conf.jinja
    - require:
      - file: /etc/logstash

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
    - content_content: logstash:ssl_cert
    - require:
      - file: /opt/logstash
{% endif %}

{% set ssl_key = salt['pillar.get']('logstash:ssl_key', False) %}
{% if ssl_key %}
/etc/logstash/logstash.key:
  file:
    - managed
    - content_content: logstash:ssl_key
    - require:
      - file: /opt/logstash
{% endif %}

{% set jar_delivery = salt['pillar.get']('logstash:jar_delivery', 'http') %}

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
# (we default to a non-existant url, just to break)
logstash_jar:
  pkg.installed:
    - name: logstash
    - sources:
      - logstash: {{ salt['pillar.get']('logstash:deb_source', 'https://youforgottosetme/somepath/logstash-1.1.13-flatjar.deb') }}
    - require:
      - pkg: logstash-jre
{% endif %}

{% if jar_delivery == 'deb/apt' %}
logstash_jar:
  pkg:
    - latest
    - name: logstash
{% endif %}

logstash:
  service:
    - running
    - watch:
      - file: /etc/init/logstash.conf
      - file: /etc/logstash/logstash.conf
    - require:
      - user: logstash
      - pkg: logstash-jre
      - file: /var/log/logstash
      - file: /opt/logstash/logstash.jar
  user:
    - present
    - fullname: Logstash
    - home: /opt/logstash
    - system: true
