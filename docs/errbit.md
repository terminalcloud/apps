# **Errbit** Terminal.com Snapshot
*The open source, self-hosted error catcher*

---

## About Errbit
**Errbit** is a tool for collecting and managing errors from other applications. It is Airbrake (formerly known as Hoptoad) API compliant, so if you are already using Airbrake, you can just point the airbrake gem to your Errbit server.

---

## Screenshots

![1](http://errbit.github.com/errbit/images/apps_thumb.png)
![2](http://errbit.github.com/errbit/images/app_errors.png)
![3](http://errbit.github.com/errbit/images/error_summary_thumb.png)
![4](http://errbit.github.com/errbit/images/error_backtrace_thumb.png)

---

## Usage
Spin up your terminal container based on this snapshot and try Erbit clicking on "Check your installation here". 


####Please login to Errbit using the default credentials below:

- Username: errbit@errbit.example.com
- Password: password

*Make sure to change that as soon as possible!*

Once you're ready to deploy Errbit to production follow this steps:
- Copy config/deploy.example.rb to config/deploy.rb
- Update the deploy.rb or config.yml file with information about your server
- Setup server and deploy `cap deploy:setup deploy db:create_mongoid_indexes`

(The capistrano deploy script will automatically generate a unique secret token.)


Authentication
--------------

### Configuring GitHub authentication:

  * In `config/config.yml`, set `github_authentication` to `true`
  * Register your instance of Errbit at: https://github.com/settings/applications

If you hosted Errbit at errbit.example.com, you would fill in:

<table>
  <tr><th>URL:</th><td>http://errbit.example.com/</td></tr>
  <tr><th>Callback URL:</th><td>http://errbit.example.com/users/auth/github</td></tr>
</table>

  * After you have registered your app, set `github_client_id` and `github_secret`
    in `config/config.yml` with your app's Client ID and Secret key.


After you have followed these instructions, you will be able to **Sign in with GitHub** on the Login page.

You will also be able to link your GitHub profile to your user account on your **Edit profile** page.

If you have signed in with GitHub, or linked your GitHub profile, and the App has a GitHub repo configured,
then you will be able to create issues on GitHub.
You will still be able to create an issue on the App's configured issue tracker.

You can change the requested account permissions by setting `github_access_scope` to:

<table>
  <tr><th>['repo'] </th><td>Allow creating issues for public and private repos.</td></tr>
  <tr><th>['public_repo'] </th><td>Only allow creating issues for public repos.</td></tr>
  <tr><th>[] </th><td>No permission to create issues on any repos.</td></tr>
</table>


## Documentation
- [Errbit C9 Website](http://errbit.github.io/errbit/)
- [Errbit repository](https://github.com/errbit/errbit)


---

### Additional Information
#### Errbit Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/errbit_installer.sh && bash errbit_installer.sh`
 

---

#### Thanks for using Errbit at Terminal.com!