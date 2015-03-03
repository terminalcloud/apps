# **Redis with Redis Commander** Terminal.com Snapshot

*Redis Server and Web Management interface*

---

## About Redis.
Redis is an open source, BSD licensed, advanced key-value cache and store. 
It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets, sorted sets, bitmaps and hyperloglogs.

### Main Features

You can run atomic operations, like appending to a string; incrementing the value in a hash; pushing an element to a list; computing set intersection, union and difference; or getting the member with highest ranking in a sorted set.
In order to achieve its outstanding performance, Redis works with an in-memory dataset. Depending on your use case, you can persist it either by dumping the dataset to disk every once in a while, or by appending each command to a log. 
Persistence can be optionally disabled, if you just need a feature-rich, networked, in-memory cache.
Redis also supports trivial-to-setup master-slave asynchronous replication, with very fast non-blocking first synchronization, auto-reconnection with partial resynchronization on net split.
Other features include:
- [Transactions](http://redis.io/topics/transactions)
- [Pub/Sub](http://redis.io/topics/pubsub)
- [Lua scripting](http://redis.io/commands/eval)
- [Keys with a limited time-to-live](http://redis.io/commands/expire)
- [LRU eviction of keys](http://redis.io/topics/lru-cache)
- [Automatic failover](http://redis.io/topics/sentinel)

You can use Redis from [most programming languages](http://redis.io/clients) out there!

---

## About Redis Commander

Redis-Commander is a node.js web application used to view, edit, and manage a Redis Database.

### Main Features

- *Config Information* - View configuration information from your Redis database
- *Tree View* - View a list of all keys in your database as an expandable tree
- *View Key Values* - View individual key values with paging support for lists/sorted sets
- *Edit Values* - Edit key values inline
- *Redis CLI* - Run Redis commands from command-line interface in your browser
- *Tab Completion* - Tab complete Redis commands and key names from the comand-line interface
- *API Popup* - View Redis commands API in popup window 

---

## Usage

Just spin up a new Terminal based on this snapshot. Redis will be already running.
Access the Redis Commander by clicking [here](https://terminalservername-8081.terminal.com).


---

![1](http://i.imgur.com/c52uzsX.png)

---

## Documentation

- [Redis Website](http://redis.io/)
- [Redis Documentation](http://redis.io/documentation)
- [Redis Support Page](http://redis.io/support)
- [Redis Commander Main Page](http://joeferner.github.io/redis-commander/)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/snapfiles/redis_c_snapfile.sh && bash redis_c_snapfile.sh`

---

#### Thanks for using Redis with Redis Commander at Terminal.com!
