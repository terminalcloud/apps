# **DevStack: Node+MongoDB+Express+Angular** Terminal.com Snapshot
*Full featured Development Stack*

---

## About NodeJS
**Node.js**® is a platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications. Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and efficient, perfect for data-intensive real-time applications that run across distributed devices.

## About MongoDB
**MongoDB** is a cross-platform document-oriented database. Classified as a NoSQL database, MongoDB eschews the traditional table-based relational database structure in favor of JSON-like documents with dynamic schemas (MongoDB calls the format BSON), making the integration of data in certain types of applications easier and faster. Released under a combination of the GNU Affero General Public License and the Apache License, MongoDB is free and open-source software.

## About ExpressJS
**Express** is a minimal and flexible Node.js web application framework that provides a robust set of features for web and mobile applications. With a myriad of HTTP utility methods and middleware at your disposal, creating a robust API is quick and easy. It provides a thin layer of fundamental web application features, without obscuring Node features. 

## About AngularJS
**AngularJS** is an open-source web application framework, maintained by Google and community, that assists with creating single-page applications, which consist of one HTML page with CSS, and JavaScript on the client side. Its goal is to simplify both development and testing of web applications by providing client-side model–view–controller (MVC) capability as well as providing structure for the entire development process, from design through testing.

---


## Usage

Spin-up your container based on this snapshot and start coding directly on it.

### Stack Characteristics:
- **Node** is installed globally on its stable version.
- **MongoDB** is installed and running on the standard port (27017).
- **Express** is installed globally and accesible by the express command.
- **Angular** is installed using bower and their components are located in /root/bower_components/angular


### Examples includded:
This snapshot includes a list of ExpressJS examples located in /root/express/examples as listed below:

examples/
|-- auth
|-- big-view
|-- content-negotiation
|-- cookie-sessions
|-- cookies
|-- cors
|-- downloads
|-- ejs
|-- error
|-- error-pages
|-- expose-data-to-client
|-- hello-world
|-- jade
|-- markdown
|-- multipart
|-- mvc
|-- online
|-- params
|-- resource
|-- route-map
|-- route-middleware
|-- route-separation
|-- search
|-- session
|-- static-files
|-- vhost
|-- view-constructor
|-- view-locals
`-- web-service

To run these examples you may run:

```
cd /root/express && npm install #One time command

node examples/<example_name>

# For instance
node examples/hello-world

```

And then check the working example at port 3000 [click here](http://terminalservername-3000.terminal.com)

---

## Documentation and Resources

#### NodeJs
- [Official Documentation and Tutorials](http://nodejs.org/documentation)
- [NodeJS Community Learning Sources](http://nodejs.org/community)

#### MongoDB
- [Manual and Docs](http://docs.mongodb.org)
- [Community Resources](http://www.mongodb.org/get-involved)
- [Blog](http://blog.mongodb.org)

#### NodeJs
- [Official Website](http://expressjs.com/)
- ["Getting Started" Guide](http://expressjs.com/guide.html)
- [API Reference (current)](http://expressjs.com/4x/api.html#application)

#### NodeJs
- [Official Website](https://angularjs.org/)
- [Github Repository](https://github.com/angular/angular.js)
- [Learning Tutorial](https://docs.angularjs.org/tutorial)
- [API Reference](https://docs.angularjs.org/api)

---


### Additional Information
#### Container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/express_installer.sh && bash express_installer.sh`


---

#### Thanks for using this development stack at Terminal.com!