# **Symfony Framework** Terminal.com Snapshot

## About **Symfony Framework**

Symfony is an Open Source PHP Web applications development framework. It was originally conceived by the interactive agency SensioLabs for the development of web sites for its own customers. Symfony was published by the agency in 2005 under MIT Open Source license and today it is among the leading frameworks available for PHP development.


Supported by SensioLabs - but also by a large community - Symfony has many resources: plentiful documentation, community support (mailing lists, IRC, etc.), professional support (consulting, training, etc.), and so on.


Available in version 2.0, Symfony already has, among the hundreds of sites and applications developed on its platform, prestigious references, such as Yahoo!, Dailymotion, Opensky.com, Exercise.com, phpBB, or Drupal.

## Usage:
Just spin up you terminal.com container based on this snapshot and you will have everything needed to develop, deploy and serve a **Symfony Application**. 

This container hace Apache web server installed, serving a sample Symfony App that can be the base for you new poject.

If you want to start your Symfony project from the scratch, just follow this simple instructions:
- Go to the folder where you want to host your application
- Create a new symfony project by executing: `composer create-project symfony/framework-standard-edition my_new_project/ "2.5.*` (replacing "my_new_project" by the actual name of your project)
- Modify the Apache config file at /etc/apache2/sites-available/sample.conf to point to your project folder.
- Restart Apache executing `service apache restart`

## Documentation and resources
- The [get started](http://symfony.com/get-started) guide
- Symfony [Official Documentation](http://symfony.com/doc/current/index.html)
- [Community, mailing list and forum](http://symfony.com/community)

### Additional Information
#### Terminal.com container automatic installation
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by excuting

`wget https://raw.githubusercontent.com/qmaxquique/terminal.com/master/symfony_installer.sh &&  bash symfony_installer.sh`

---

#### Thanks for using Symfony at Terminal.com!