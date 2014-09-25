# **CLING** Terminal.com Snapshot
*Interactive C++ interpreter, built on the top of LLVM and Clang libraries*

---

## About CLING
**Cling** is an interactive C++ interpreter, built on the top of LLVM and Clang libraries. Its advantages over the standard interpreters are that it has command line prompt and uses just-in-time (JIT) compiler for compilation. Many of the developers (e.g. Mono in their project called CSharpRepl) of such kind of software applications name them interactive compilers.



One of Cling's main goals is to provide contemporary, high-performance alternative of the current C++ interpreter in the ROOT project - CINT. The backward-compatibility with CINT is major priority during the development.

---

### Features
- *Command Line* - Cling has its own command line, which looks like any other Unix shell. The emacs-like command line editor is what we call interactive command line or interactive shell. Once we start Cling it automatically includes several header files and its own runtime universe. Thus it creates the minimal environment for the user to start.

- *Grammar* - Cling is capable to parse everything that Clang can do. Current clang status can be found [here](http://clang.llvm.org/cxx_status.html). In addition Cling will be able to parse the CINT specific C++ extensions.

- *Metaprocessor* - Cling Metaprocessor provides convenient and easy to use interface for changing the interpreter's internal state or for executing handy commands. Cling provides the following metaprocessor commands:


---

## Usage
Spin up your terminal container based on this snapshot and start using the Cling interpreter immediately!


#### To start Cling in a new console, just ejecute 
**`cling`**

#### Other usage examples

`cling '#include <stdio.h>' 'printf("Hello World!\n")'`

To get started run: `cling --help` or type `cling [cling]$ .help`


### Syntax - Quick Guide

** .(command), where command is:**

- .x filename.cxx - loads filename and calls void filename() if defined
- .L library | filename.cxx - loads library or filename.cxx
- .printAST - shows the abstract syntax tree after each processed entity
- .I path - adds an include path

_Check the Resources and Doucumentation section for more information about Cling._

---

## Resources and Documentation
- [CLING Forum](http://root.cern.ch/phpBB3/viewforum.php?f=21)
- Contact the developers at cling-dev@cern.ch
- LLVM Developers' Meeting, "Creating cling, an interactive interpreter interface for clang", Axel Naumann, Philippe Canal, Paul Russo, Vassil Vassilev, 04.11.2010, San Jose, CA, United States - [Slides](http://llvm.org/devmtg/2010-11/Naumann-Cling.pdf) | [Video](http://llvm.org/devmtg/2010-11/videos/Naumann_Cling-desktop.mp4)
- Google Tech Talk ([slides](http://root.cern.ch/drupal/sites/default/files/AxelNaumann-cling-GoogleTech.pdf) | [video](http://www.youtube.com/watch?v=f9Xfh8pv3Fs))
- More [Clang-centric presentations](http://root.cern.ch/viewvc/trunk/interpreter/cling/www/docs/talks/)

---

### Additional Information

The [Low Level Virtual Machine (LLVM)](http://llvm.org/) is a compiler infrastructure, written in C++, which is designed for compile-time, link-time, run-time, and "idle-time" optimization of programs written in arbitrary programming languages. Originally implemented for C/C++, the language-independent design (and the success) of LLVM has since spawned a wide variety of front ends, including Objective-C, Fortran, Ada, Haskell, Java bytecode, Python, Ruby, ActionScript, GLSL, and others.


[Clang](http://clang.llvm.org/) is a compiler front end for the C, C++, Objective-C and Objective-C++ programming languages. It uses the Low Level Virtual Machine (LLVM) as its back end, and as such Clang is part of LLVM releases since LLVM 2.6. Its goal is to offer a replacement to the GNU Compiler Collection (GCC). Development is sponsored by Apple. Clang is available under a free software licence.


#### CLING Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/cling_installer.sh && bash cling_installer.sh`

---

#### Thanks for using CLING at Terminal.com!