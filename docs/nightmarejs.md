# **NightmareJS** Terminal.com Snapshot
*A high level wrapper for Phantomjs.*

---

## About NightmareJS
Nightmare is a high level wrapper for [PhantomJS](http://phantomjs.org/) that lets you automate browser tasks.

The goal is to expose just a few simple methods, and have an API that feels synchronous for each block of scripting, rather than deeply nested callbacks. It's designed for automating tasks across sites that don't have APIs.

---

## Examples

Let's search on Yahoo:

```
var Nightmare = require('nightmare');
new Nightmare()
  .goto('http://yahoo.com')
    .type('input[title="Search"]', 'github nightmare')
    .click('.searchsubmit')
    .run(function (err, nightmare) {
      if (err) return console.log(err);
      console.log('Done!');
    });
```

Or, let's extract the entirety of Kayak's home page after everything has rendered:

```
var Nightmare = require('nightmare');
new Nightmare()
  .goto('http://kayak.com')
  .evaluate(function () {
    return document.documentElement.innerHTML;
  }, function (res) {
    console.log(res);
  })
  .run();
```

Or, here's how you might automate a nicely abstracted login + task on Swiftly:

```
var Nightmare = require('nightmare');
var Swiftly = require('nightmare-swiftly');
new Nightmare()
  .use(Swiftly.login(email, password))
  .use(Swiftly.task(instructions, uploads, path))
  .run(function(err, nightmare){
    if (err) return fn(err);
    fn();
  });
```

And [here's the `nightmare-swiftly` plugin](https://github.com/segmentio/nightmare-swiftly).


---

We also include an extended version of the Yahoo search script that will let you use the Terminal.com IDE to debug your automations.
See **Usage** for more information.

---

## Usage

Just spin-up your container based on this snapshot and start coding your Nightmarejs automation scripts directly on the editor window.
An example of how to use the Terminal.com IDE to help you to see the results of your scripts using screenshots it included.

Just execute: `cd ~/nightmarejs && nodejs web_search.js "search term"` and you will see the results in the IDE browser.

**To see this help page again, execute ~/show_help.sh**

For more information about the API use, please check the [Complete API documentation](https://github.com/segmentio/nightmare#api)

### Credentials:

- username: admin
- password: t3rminal

---

## Documentation
- [NightmareJS Main Website](http://www.nightmarejs.org/)
- [Complete API documentation](https://github.com/segmentio/nightmare#api)
- [Github Repo](https://github.com/segmentio/nightmare)

---

### Additional Information

#### Nightmarejs Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/nightmarejs_installer.sh && bash nightmarejs_installer.sh`

---

#### Thanks for using NightmareJS at Terminal.com!