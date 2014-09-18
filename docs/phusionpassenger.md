# **Phusion Passenger** Terminal.com snapshot

## About **Phusion Passenger**
**Phusion Passenger** is a web server and application server. Designed to be fast, robust and lightweight. Makes web app deployments a lot simpler and less complex, by managing your apps' processes and resources for you.

### Features

- **Continous Delivery** - Continuously improving your product without any downtime. Rolling restarts allows you to deploy new versions without your users noticing.
- **Reliable** - No more worries, just a stable server to serve all your users at any time to deliver the best product experience.
- **Scalable** - Phusion Passenger keeps up with the growing demands of your users and customers so you can serve millions of them.
- **Fast and Lightweight** - Optimized for performance and concurrency, designed to be infinitely horizontally scalable, and uses less than 5 MB of memory. Make your web app fly like never before.
- **Easy to use** - No more headaches or wasting hours figuring things out. Focus on your primary task, not on micro-managing software.
- **Developer Friendly** - Develop your app faster and with more pleasure than ever. Use our Cache API, Queue API, Background Worker API, and more.

## Snapshot/Container contents

This Terminal.com container has a fully functional **Phusion Passenger** server installed and configured to be used with **Nginx** web server and a sample blog application written in Ruby, currently server via Passenger.


The **Nginx** installation has been compiled specially to be used with **Phusion Passenger** modules and it's available to be used to server any of this kind of applications:
- Ruby/Rails Apps.
- Python/Django Apps. 
- Nodejs Apps.
- Meteor Apps.


The sample application is a Ruby blog app called [Serious](https://github.com/colszowka/serious).

## Usage
Just spin up your Phusion Passenger container and see Passenger serving a sample application.

Upload or develop your own application, and configure Nginx to serve it from the container.

Use `passenger-status` to monitor your application status and `passenger-memory-stats` to check your _passenger_ memory usage. (remember you can change the amount of memory and CPU assigned to your terminal container anytime!)

## Documentation
- [Phusion Passenger Official Website](https://www.phusionpassenger.com/documentation/Users%20guide%20Nginx.html)
- [Phusion Passenger for Nginx Documentation](https://www.phusionpassenger.com/documentation/Users%20guide%20Nginx.html)
- [Nginx Server Documentation](http://wiki.nginx.org/Resources)
- Sample: [Serious GitHub Repository](https://github.com/colszowka/serious)


### Additional Information
#### Terminal.com container automatic installation
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing

`wget https://raw.githubusercontent.com/terminalcloud/apps/master/phusionpassenger_install.sh && bash phusionpassenger_install.sh`

**We recomend to start at least start with a "Small" terminal due the compilation memory requirements**

---

#### Thanks for using Phusion Passenger at Terminal.com!
