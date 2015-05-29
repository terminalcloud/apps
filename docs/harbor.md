# Harbor

#### An API bridge program specially designed to let you work with Terminal.com, as you were using docker.

---

## About Harbor

Harbor works like a bridge between any docker compatible client and the Terminal.com API. 
In that way, you can use docker commands to work with Terminals making any already existing docker workflow compatible with Terminals.

![](http://i.imgur.com/zkdYyRH.png)

The theoretical approach of **Harbor** is to make the conceptual conversion, as close as possible, of docker and Terminal components.

With that idea in mind, you will be able to use Terminals as they were docker containers, or use snapshots as they were docker images.

---

## Installation and usage

**Harbor** is designed to work on a Terminal, so you don't need nothing special. 
Just start the [Harbor Snapshot](https://www.terminal.com/snapshot/d65bfbaba5e638afc6b3f05c3c7fbffe25bf9b1a876462eff2efbf681eb325bd) and follow the on-screen instructions to configure it.

You can use it directly from the Harbor Terminal, which has installed the latest docker client, 
or connect to it by tunneling the port via ssh and repointing the client to the port where Harbor is listening.

---

## Documentation

To know more about Harbor, please visit our [official blog post](https://blog.terminal.com/harbor) 
or the Harbor [Github Repo](https://github.com/terminalcloud/harbor)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/harbor_installer.sh && bash harbor_installer.sh`

---

#### Thanks for trying Harbor!