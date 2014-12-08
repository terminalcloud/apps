var Nightmare = require('nightmare');
var exec = require('child_process').exec;
 
// Receive arguments from the console.
var arguments = process.argv.slice(2);
console.log("Searching: " + arguments);
 
new Nightmare()
  .goto('http://yahoo.com')
  .type('input[title="Search"]', arguments)
  .click('.searchsubmit')
 
  // Wait until the page loads, then take a screenshot.
  .wait()
  .screenshot('./scr.jpg')
  .run(function (err, nightmare) {
    if (err) return console.log(err);
    console.log('Displaying results');
    
    // Fork the process to show the screenshot in the IDE browser.
    exec('/srv/cloudlabs/scripts/display.sh scr.jpg');
    console.log('Done!');
  });