# **ArcheoloGit** Terminal.com Snapshot

*Data visualization tool to show the age and dev activity for git repositories*

---

## About ArcheoloGit

**ArcheoloGit** is a visualization of age and dev activity for software, powered by d3.js.

ArcheoloGit displays all files of a given application as rectangles. The size of each rectangle is proportional to the number of commits, the color is green if the file was recently modified, red if it hasn't been modified for a long time.

Therefore:

- Large red rectangles show files modified often, but untouched for a long time.
- Small red rectangles show files seldom modified, and untouched for a long time.
- Small green rectangles show files seldom modified, but created or modified recently.
- Large green rectangles show files modified a lot of times, including recently.

---

![1](http://marmelab.com/images/blog/nav.gif)


---

This Terminal snapshot was created with [Pulldocker]() from the [clue/ttrss](https://registry.hub.docker.com/u/clue/ttrss/) docker image.

---


## Usage

ust spin up a new Terminal based on this snapshot and access the application by clicking to "Check your installation here".

---

## Documentation

- [ArcheoloGit website]()
- [Documentation]()

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/archeologit_installer.sh && bash archeologit_installer.sh`

---

#### Thanks for using ArcheoloGit at Terminal.com!
