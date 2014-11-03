# **YOURLS** Terminal.com Snapshot
*Your **own** URL **Shortener***


## About YOURLS
**YOURLS** stands for **Your Own URL Shortener**. It is a set of PHP scripts that will allow you to run your own URL shortening service (like TinyURL or bitly).

Running your own URL shortener is fun, geeky and useful: you own your data and don't depend on third party services. It's also a great way to add branding to your short URLs, instead of using the same public URL shortener everyone uses.

### Features
- Free and Open Source software.
- Private (your links only) or Public (everybody can create short links, fine for an intranet)
- Sequential or custom URL keyword
- Handy bookmarklets to easily shorten and share links
- Awesome stats: historical click reports, referrers tracking, visitors geo-location
- Neat Ajaxed interface
- Terrific Plugin architecture to easily implement new features
- Cool developer API
- Full jsonp support
- Friendly installer
- Sample files to create your own public interface and more

### Some screenshots
![1](https://yourls.org/yourls-org-images/admin-dashboard.gif)
---
![2](https://yourls.org/yourls-org-images/stats-anim.gif)

## Usage
Spin up your terminal container based on this snapshot and click to the link provided.

Due the way YOURLS works, you will have to login to the system by going to /admin and authenticate using the default user and password: ` user: admin , password: password ` To change this password just edit the user/config.php file. The passwords will be automatically encrypted during the next run.

As any other URL shortener, YOURLS is intended to be used with short domain names.
To use you own _short_ domain name in a Terminal.com container please follow the instructions [here](https://www.terminal.com/faq#cname)

### Additional Configuration
To complete or change the system configuration you need to edit the file user/config.php. By editing that file you will be able to change basic configuration parameters as:
- **Users and Passwords** - The information will be encrypted during the first run
- **Site URL** - This is needed when you configure your own shortener domain.
- **Db and Stuff** - You may want to change the DB name or passwords in the future.

## Documentation
- [YOURLS Website](http://yourls.org/)
- [FAQs](http://yourls.org/#FAQ)
- [API Documentation](http://yourls.org/#API)


### Additional Information
#### YOURLS Terminal.com container automatic installation:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/yourls_installer.sh && bash yourls_installer.sh`

---

#### Thanks for using YOURLS at Terminal.com!