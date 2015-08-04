# **InfluxDB** Terminal.com Snapshot
*A modern time series database*

---

## About InfluxDB

InfluxDB is an open-source distributed time series database with no external dependencies


---

## Main Features

- **Metrics** - Pair InfluxDB with Grafana, CollectD, Sensu, or cAdvisor to roll your own custom DevOps solutions. 
You'll have full visibility into your infrastructure, servers, applications, and containers.
- **Real-time Analytics** - Track user and business analytics in real-time with InfluxDB. Use a client library in your 
favorite language to track events and numbers and visualize it all with realtime dashboards on top of Grafana.
- **Sensor Data** - InfluxDB is designed to track data from tens of thousands of sensors all sampling at rates of once 
a second or more. Using the Influx JavaScript library and your favorite charting library, you can build custom sensor 
analytics in a few hours.

---

## Command line interface

Spin up a new Terminal based on this snapshot. 
Access the Influxdb CLI by executing `/opt/influxdb/influx`

### Web interface.

In a Terminal, using the web interface is only supported over http.
You will have to configure the web interface connection settings as follows:

Host=terminalservername-8086.terminal.com 
Port=80

Check this example:

![1](http://i.imgur.com/aZZOXo2.png?1)

---

## Documentation

- [InfluxDB website](https://influxdb.com/)
- [Documentation](https://influxdb.com/docs/v0.9/introduction/overview.html)
- [Blog](https://influxdb.com/blog.html)
- [Community pages](https://influxdb.com/community/index.html)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/influxdb_installer.sh && bash influxdb_installer.sh`

---

#### Thanks for using InfluxDB at Terminal.com!