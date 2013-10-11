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

logstash:
  file:
    - managed
    - source: https://download.elasticsearch.org/logstash/logstash/logstash-1.1.13-flatjar.jar
    - source_hash: md5=fdb8dc147a4a54622b1212ead926be5b
    - name: /opt/logstash/logstash.jar
    - user: root
    - group: root
    - mode: 664
    - require:
      - file: /opt/logstash
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
