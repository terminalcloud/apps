# **ELK Stack** Terminal.com Snapshot

*Logstash, Kibana and Elasticseach ready to use!.*

---

## About this ELK Stack

Combining the massively popular Elasticsearch, Logstash and Kibana. 
ELK is an end-to-end stack that delivers actionable insights in real-time from almost any type of structured and unstructured data source. 
Built and supported by the engineers behind each of these open source products, the Elasticsearch ELK stack makes searching and analyzing data easier than ever before.

---

### ***elasticsearch***
Elasticsearch is a flexible and powerful open source, distributed, real-time search and analytics engine. 

### ***logstash***
Logstash helps you take logs and other time based event data from any system and store it in a single place for additional transformation and processing.

### ***kibana***
Kibana is Elasticsearch’s data visualization engine, allowing you to natively interact with all your data in Elasticsearch via custom dashboards. 
Kibana’s dynamic dashboard panels are savable, shareable and exportable, displaying changes to queries into Elasticsearch in real-time. 


[More information](http://www.elasticsearch.org/overview/)


---

## Usage

Just spin up a new Terminal based on this snapshot.

- Logstash will be already and waiting for you to put configuration files at `/etc/logstash/config.d`
- Elasticsearch will be already running on port `9200`
- Kibana will be running http://terminalservername-80.terminal.com/kibana


---

![1](http://i.imgur.com/MFJ86MQ.png)

---

## Documentation

- [ELK website](http://www.elasticsearch.org/)
- [Elasticsearch](http://www.elasticsearch.org/overview/elasticsearch/)
- [Logstash](http://www.elasticsearch.org/overview/logstash)
- [Kibana](http://www.elasticsearch.org/overview/kibana)
- [Terminal Blog entry!](https://blog.terminal.com/elk-for-log-analysis)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/elk_installer.sh && bash elk_installer.sh`

---

#### Thanks for using ELK at Terminal.com!
