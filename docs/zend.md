# **Zend Framework 2** Terminal.com Snapshot

## About **Zend Framework 2**


Zend Framework 2 is an open source framework for developing web applications and services using PHP 5.3+. Zend Framework 2 uses 100% object-oriented code and utilises most of the new features of PHP 5.3, namely namespaces, late static binding, lambda functions and closures.

Zend Framework 2 evolved from Zend Framework 1, a successful PHP framework with over 15 million downloads.

The component structure of Zend Framework 2 is unique; each component is designed with few dependencies on other components. ZF2 follows the SOLID object oriented design principle. This loosely coupled architecture allows developers to use whichever components they want. We call this a “use-at-will” design. We support Pyrus and Composer as installation and dependency tracking mechanisms for the framework as a whole and for each component, further enhancing this design.


While they can be used separately, Zend Framework 2 components in the standard library form a powerful and extensible web application framework when combined. Also, it offers a robust, high performance MVC implementation, a database abstraction that is simple to use, and a forms component that implements HTML5 form rendering, validation, and filtering so that developers can consolidate all of these operations using one easy-to-use, object oriented interface. Other components, such as Zend\Authentication and Zend\Permissions\Acl, provide user authentication and authorization against all common credential stores.

The principal sponsor of the project ‘Zend Framework 2’ is Zend Technologies, but many companies have contributed components or significant features to the framework. Companies such as Google, Microsoft, and StrikeIron have partnered with Zend to provide interfaces to web services and other technologies they wish to make available to Zend Framework 2 developers.

## Usage:
Just spin up you terminal.com container based on this snapshot and you will have everything needed to develop, deploy and serve a **Zend Framework 2 Application**. 

This container have Apache web server installed, serving a sample Zend Framework 2 App that can be used to learn how a CRUD is done.

If you want to start your Zend project from the scratch, just follow this simple instructions:
- Go to the folder where you want to host your application
- Create a new zend project by executing: `composer create-project --repository-url="http://packages.zendframework.com" zendframework/skeleton-application my_new_project/ ` (replacing "my_new_project" by the actual name of your project)
- Modify the Apache config file at /etc/apache2/sites-available/sample.conf to point to your project folder.
- Restart Apache executing `service apache2 restart`

## Documentation and resources
- The [get started](http://framework.zend.com/downloads) guide
- Zend Framework 2 [Official Documentation](http://http://framework.zend.com/manual/2.3/en/index.html)
- [Community, mailing list and forum](http://http://framework.zend.com/participate/)

### Additional Information
#### Terminal.com container automatic installation
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by excuting

`wget  https://raw.githubusercontent.com/terminalcloud/apps/master/zend_installer.sh &&  bash zend_installer.sh`

---

#### Thanks for using Zend Framework 2 at Terminal.com!
