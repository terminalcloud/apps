# **Wallabag** Terminal.com Snapshot
*Self hostable application for saving web pages*

---

## About Wallabag
**Wallabag** (formerly poche) is a self hostable application for saving web pages. Unlike other services, Wallabag is free and open source.

With this application you will not miss content anymore. **Click, save, read it when you want**. It saves the content you select so that you can read it when you have time.

### Some Screenshots
![1](https://www.wallabag.org/wp-content/uploads/2014/03/homepage_grid.jpeg)
---
![2](https://www.wallabag.org/wp-content/uploads/2014/03/homepage_smartphone.png)
![2](https://www.wallabag.org/wp-content/uploads/2014/03/article_smartphone-150x150.png)


### Features
- Wallabag is free and open source. Forever.
- No time to read? Save a link in your wallabag to read it later
- Read the saved articles in a comfortable view: the content, only the content
- You save all the content: text and pictures
- You can easily migrate from others private services.
- You like an article? Share it by email, on twitter or in your shaarli
- Because we are increasingly mobile, wallabag fits all your devices
- Saving a link is so easy because we provide you many tools: extensions for Chrome and Firefox, iOS, Android and -Windows Phone application, a bookmarklet, a simple field in your config webpage. [You can download third-party applications here.](https://www.wallabag.org/downloads/)
- RSS feeds allows you to read your saved links in your RSS agregator
- You can set tags to your entries.
- Wallabag is multilingual: french, english, spanish, german, italian, russian, persian, czech, polish, ukrainian and slovienian.
- You’re not the only one at home to use wallabag? it’s good, wallabag is multi users
- You prefer a dark template? Perfect, many templates are available in the configuration screen
- Many storage allowed: sqlite, mysql and postgresql
- Scroll position is saved: when you return on an article, you come back where you was. So convenient!
- You can flattr flattrable articles directly from your Wallabag
- You want to retrieve your Wallabag datas? hey, remember, wallabag is open source, you can export it


## Usage
Spin up your terminal container based on this snapshot and personalize your installation by clicking on "Finish your installation here"
To get a better performance we provide a preconfigured MySQL DB for Wallabag. 

**Just use the information below on the installation page**

- MQL host: localhost

- MySQL db: wallabag

- MySQL user: wallabag

- MySQL pass: terminal

Once the product is installed you will be able to use it directly or through any of their [3rd Party apps](https://www.wallabag.org/downloads/) 


## Documentation
- [Wallabag Docs main page ](http://doc.wallabag.org/doku.php)
- [FAQs](https://www.wallabag.org/frequently-asked-questions/)
- [Wallabag Blog](https://www.wallabag.org/blog/)
- [GitHub Repo](https://github.com/wallabag/wallabag)


### Additional Information
### 3rd Party Apps configuration
To configure 3rd party Apps with Wallabag you will have to provide a server address. In this case, your server address is: ** terminalservername **


#### Wallabag Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by excuting:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/wallabag_installer.sh && bash wallabag_installer.sh`

---

#### Thanks for using Wallabag at Terminal.com!