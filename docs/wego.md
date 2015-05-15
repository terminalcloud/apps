#**wego** Terminal.com Snapshot

**wego is a weather client for the terminal.**

---

##Features

- Show forecast for 1 to 5 days
- Nice ASCII art icons
- Displayed info (metric or imperial units):
  * Temperature
  * Windspeed and direction
  * Viewing distance
  * Precipitation amount and probability
- Ssl.
- Config file for default location which can be overridden by commandline

![Screenshots](http://schachmat.github.io/wego/wego.gif)

## Usage
- Run `wego`  and you should get the weather forecast for the current
   and next 2 days.
- If you're visiting someone in e.g. London over the weekend, just run
   `wego 4 London` or `wego London 4` (the ordering of arguments makes no
   difference) to get the forecast for the current and the next 3 days.




### General Notes
This Terminal has a test key preconfigured on it. You may want to replace it by your own key from [here.](https://developer.worldweatheronline.com/auth/register)

## Documentation

- [**wego**] Github Repo](https://github.com/schachmat/wego/)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/snapfiles/wego_snapfile && bash wego_snapfile`

---

#### Thanks for using Wego at Terminal.com!