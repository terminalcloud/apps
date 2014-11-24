// This is a simple load balancer registration server
// It listen to new registrations based on an API key.

// To register a new server against the load balancer use cURL
// values (csv) = key,ip,port,maxfails,timeout


var nginx_configfile = 'testfile.conf';
var KEY_file = 'key.txt';
var PID_file = 'nginx.pid';
var restify = require('restify');
var execSync = require("exec-sync");
var fs = require('fs');

var key = fs.readFileSync(KEY_file,'utf8').trim();
var nginx_PID = fs.readFileSync(PID_file,'utf8').trim();
var ip =  execSync("echo 10.0.0.1");

function register(req, res, next) {
  var values = req.params.data.split(',');
  // Basic checks
  if (values.length != 5) {
    console.log('Malformed URL - '+'Expecting 5 values but receiving ' + values.length);
    res.send('Malformed URL: We expect {key,ip,port,maxfails,timeout;}');
    next();
  } else if (values[1].split('.').length != 4) {
    console.log('IP not valid');
    res.send('Malformed URL - IP not valid');
    next();
  }

  var getkey = values[0];
  var ip = values[1];
  var port = values[2];
  var maxfails = values[3];
  var timeout = values[4];


  if (getkey == key){
    console.log('key is ok');
  } else
    console.log('the key should be ' + key);
  }

  // Change nginx config file
  execSync("sed -i '7i server "+ ip + ":" + port + " max_fails=" + maxfails + " timeout=" + timeout + "s;' " + nginx_configfile);
  console.log('Sending a HUP signal to' + pid);
  execSync("kill -HUP " + nginx_PID);
  res.send(200);
  next();
}


var server = restify.createServer();
server.get('/reg/:data', register);

server.listen(5500, function() {
  console.log('%s listening at %s', server.name, server.url);
});
