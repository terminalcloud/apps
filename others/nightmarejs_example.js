// Receive arguments from the console
var arguments = process.argv.slice(2);
console.log("Searching: " + arguments)

var Nightmare = require('nightmare');
new Nightmare()
	.goto('http://yahoo.com')
	.type('input[title="Search"]', arguments)
	.click('.searchsubmit')
	// Wait until this is done before take the snapshot.
	.wait(5000)
	.screenshot('./scr.jpg')
	.run(function (err, nightmare) {
		if (err) return console.log(err);
		var exec = require('child_process').exec;
		console.log('Displaying results')
		// Fork a script to show the screenshot on the browser IDE component.
		exec('/srv/cloudlabs/scripts/display.sh scr.jpg', function callback(error, stdout, stderr){ });
		console.log('Done!');
	});

