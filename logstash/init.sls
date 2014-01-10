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

logstash_jar:
  pkg:
    - installed
    - name: logstash
{% set logstash_version = salt['pillar.get']('logstash:version', False) -%} 
{% if logstash_version -%} 
    - version: {{ logstash_version }}
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
    - require:
      - pkg: logstash_jar

/etc/logstash/patterns:
  file:
    - recurse
    - user: root
    - group: root
    - file_mode: 644
    - source: salt://logstash/files/patterns
    - require:
      - file: /etc/logstash

/etc/logstash/conf.d:
  file:
    - recurse
    - template: jinja
    - user: root
    - group: root
    - file_mode: 644
    - source: salt://logstash/templates/conf.d
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

# TODO migrate to "- contents_pillar: logstash:ssl_cert" when we upgrade to 0.17
# In the meantime, use jinja templates that print pillars into the files
#
# TODO assign logstash:ssl_cert from secrets:logstash:ssl_cert when we upgrade
# to 0.17 and can include pillars in pillars or use import_yaml
#
# if we have an SSL cert&key, drop it in place
{% set ssl_cert = salt['pillar.get']('logstash:ssl_cert', salt['pillar.get']('secrets:logstash:ssl_cert', False)) %}
{% if ssl_cert %}
/etc/logstash/logstash.crt:
  file:
    - managed
    - template: jinja
    - source: salt://logstash/templates/logstash.crt.jinja
    - require:
      - file: /opt/logstash
{% endif %}

{% set ssl_key = salt['pillar.get']('logstash:ssl_key', salt['pillar.get']('secrets:logstash:ssl_key', False)) %}
{% if ssl_key %}
/etc/logstash/logstash.key:
  file:
    - managed
    - template: jinja
    - source: salt://logstash/templates/logstash.key.jinja
    - user: logstash
    - group: adm
    - mode: 600
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
      - pkg: logstash_jar
      - file: /var/log/logstash
  user:
    - present
    - fullname: Logstash
    - home: /opt/logstash
    - system: true
