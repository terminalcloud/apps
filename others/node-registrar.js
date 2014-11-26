// This is a simple load balancer registration server
// It listen to new registrations based on an API key.

// To register a new server against the load balancer use cURL
// values (csv) = key,ip,port,maxfails,timeout


var nginx_configfile = '/opt/loadbalancer/etc/nginx-lb.conf';
var KEY_file = '/opt/loadbalancer/etc/server.key';
var PID_file = '/var/run/nginx.pid';
var restify = require('restify');
var execSync = require("exec-sync");
var fs = require('fs');

var key = fs.readFileSync(KEY_file,'utf8').trim();
var nginx_PID = fs.readFileSync(PID_file,'utf8').trim();

function register(req, res, next) {
  var values = req.params.data.split(',');
  // Vars everywhere to keep it clean
  var getkey = values[0];
  var ip = values[1];
  var port = values[2];
  var maxfails = values[3];
  var timeout = values[4];

  // Basic checks
  if (values.length != 5) {
    console.log('Malformed URL - '+'Expecting 5 values but receiving ' + values.length);
    res.send(400);
  } else if (values[1].split('.').length != 4) {
    console.log('IP not valid');
    res.send(400);
  } else if (getkey != key){
    console.log('Unauthorized try');
    res.send(401);
  } else {
    // Change nginx config file
    console.log('Everything seems to be right, Registering $ip as a load-balanced node');
    execSync("sed -i '7i server "+ ip + ":" + port + " max_fails=" + maxfails + " fail_timeout=" + timeout + "s;' " + nginx_configfile);
    console.log('Sending a HUP signal to ' + nginx_PID);
    execSync("kill -HUP " + nginx_PID);
    res.send(200);
  }
}


var server = restify.createServer();
server.get('/reg/:data', register);

server.listen(5500, function() {
  console.log('%s listening at %s', server.name, server.url);
});
