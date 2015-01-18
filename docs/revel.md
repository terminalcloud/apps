# Welcome to Revel **Terminal.com** Snapshot
####[Revel](http://revel.github.io) -  High-productivity web framework for the Go language.

## About Revel
[Revel](http://revel.github.io) is a web framework for the Go Languaje centered in coding productivity.

### Features
- **Hot Code Reload** - Edit, save, and refresh. Revel compiles your code and templates for you, so you don't miss a beat. Code doesn't compile? It gives you a helpful description. Run-time code panic? Revel has you covered.
- **Comprehensive** - Revel provides routing, parameter parsing, validation, session/flash, templating, caching, job running, a testing framework, and even internationalization.
- **High Performance** - Revel builds on top of the Go HTTP server, which was recently benchmarked to serve three to ten times as many requests as Rails across a variety of loads.

- **Synchronous** - The Go HTTP server runs each request in its own goroutine. Write simple callback-free code without guilt.
- **Stateless** - Revel provides primitives that keep the web tier stateless for predictable scaling. For example, session data is stored in the user cookie, and the cache is backed by a memcached cluster.
- **Modular** - Revel is built around composable middleware called filters, which implement nearly all request-processing functionality. Developers have the freedom to replace the default filters with custom implementations (e.g. a custom router).

## Usage
Just spin up you terminal container based on this snapshot and start testing Revel features.
You will be able to try 6 different samples on the browser and terminal tabs! - *By default you will have the chat sample running.*

If you want to start coding with Revel, you can start from the samples provided and checking the [Revel documentation](http://revel.github.io/manual/index.html).

Another easy way to start with Revel is this [Revel Tutorial](http://revel.github.io/manual/index.html)

## Samples
The samples included are:
- [Booking](http://revel.github.io/samples/booking.html)- A database-driven hotel-booking application, including user management.
- [Chat](http://revel.github.io/samples/chat.html) - A chat room demonstrating active refresh, long-polling (comet), and websocket implementations.
- [Validation](http://revel.github.io/samples/validation.html) - A demonstration of the validation system.
- [Twitter OAuth](http://revel.github.io/samples/twitter-oauth.html) - A sample app that displays mentions and allows posting to a Twitter account using OAuth.
- [Facebook OAuth2](http://revel.github.io/samples/facebook-oauth2.html) - A sample app that displays Facebook user information using OAuth2.

To run each one in the terminal container, just execute this execute it and follow the on-screen instructions

`revel run github.com/revel/revel/samples/`***"sample name"***

(For instance, `revel run github.com/revel/revel/samples/chat`)

## Additional Information
The Revel container can also be installed in another [base terminal](https://www.terminal.com/tiny/V9c91eUCy8) by running [this script](https://raw.githubusercontent.com/qmaxquique/terminal.com/master/revel_installer.sh); or from a terminal tab, by executing:

`wget https://raw.githubusercontent.com/terminalcloud/apps/master/revel_installer.sh && bash revel_installer.sh`

____

####_Enjoy using Revel at Terminal.com !_