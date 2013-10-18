#logstash-formula

Install logstash.  Targeted at logstash-1.2.

## Philsophy 
* Configuration in /etc/logstash
  * fragments in /etc/logstash/conf.d (so that other states can drop in config without having to touch the generic config)   
  * patterns in /etc/logstash/patterns
* jar in /opt/logstash, which is also the logstash users homedir
* jar can be delivered via http, deb/http or deb/apt.
  * http is the default, set jar_source & jar_hash to use an alternative http source
  * deb/http   

## Configurable Items

Configurable via a logstash pillar:

item | type | default |  description
-----|------|------------
redis_enabled | boolean | False | enable redis output or not
redis_host | | 127.0.0.1 |
redis_key | | logstash | 
redis_password| | '' | 
redis_port | | 6379 | 
elasticsearch_http | boolean | False | Enable the elasticsearch_http output
elasticsearch_host | string | 127.0.0.1 | 
jar_delivery | string | http | http, deb/http, deb/apt
jar_source | string | https://download.elasticsearch.org/logstash/logstash/logstash-1.1.13-flatjar.jar |
jar_hash | string | md5=fdb8dc147a4a54622b1212ead926be5b
ssl_cert | boolean/string | False | if set, drop /etc/logstash/logstash.crt & /etc/logstash/logstash.key in place, contents from the pillar items
ssl_key | string | | see vagrant/pillar/logstash.sls for an example
tags | array | [] | optional array of tags to add to every event passing through



