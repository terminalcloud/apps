# **Toshi** Terminal.com Snapshot
*An open source Bitcoin node built to power large scale web applications.*

---

**Toshi** is a complete implementation of the Bitcoin protocol, written in Ruby and backed by PostgreSQL. It provides a RESTful API that is ideal for building scalable web applications or analyzing blockchain data.

It  is designed to be fully compatible with [Bitcoin Core](https://github.com/bitcoin/bitcoin).
It performs complete transaction and block validation, and passes 100% of TheBlueMatt's
[regression test suite](https://github.com/TheBlueMatt/test-scripts).
For much of the core protocol logic, Toshi makes use of the [bitcoin-ruby](https://github.com/lian/bitcoin-ruby)
library written and maintained by Julian Langschaedel.

Toshi was built at [Coinbase](https://coinbase.com), with the goal of replacing
our core Bitcoin network infrastructure in the near future. It is currently in beta,
and not recommended for production use until it has received sufficient testing
from the Bitcoin community.

You can see Toshi running on various networks at the following URLs:

* https://bitcoin.toshi.io/
* https://testnet3.toshi.io/
* https://litecoin.toshi.io/

## Features

 * Complete Bitcoin node implementation
 * Fully passes TheBlueMatt's [regression test suite](https://github.com/TheBlueMatt/test-scripts)
 * PostgreSQL backed (more convenient for web applications and research)
 * JSON, Hex, and Binary API
 * Simple web [interface](https://bitcoin.toshi.io) to monitor node status

---

## What is a Bitcoin node?

A Bitcoin node is simply a client on the Bitcoin peer-to-peer network. It validates and relays transactions and blocks to other clients according to the consensus rules as implemented in [Bitcoin Core](https://github.com/bitcoin/bitcoin). A "full node" implies that the client retains a complete copy of the Bitcoin blockchain.


## Toshi vs. Bitcoin Core

**Toshi** is a Bitcoin implementation designed for building highly scalable web applications. It allows you to query the blockchain using a REST API or raw SQL. It comprises a number of individual services, using a shared database. Because Toshi saves much more information and indexes more data than Bitcoin Core, it requires much more space to store the blockchain (~220GB vs ~25GB as of September 2014). However, this makes it possible to run much richer queries that would otherwise not be possible with Bitcoin Core.

**Bitcoin Core** (the reference implementation) is designed to run on a single server, and uses a mixture of raw files and LevelDB to store the blockchain. It allows you to query the blockchain using a JSON-RPC interface.

Some examples of queries which Toshi can easily answer, which are not possible with Bitcoin Core:

* List all unspent outputs for any address (Bitcoin Core only indexes unspent outputs for specific addresses added to the local "wallet").
* Get the balance of any address
* Get the balance of any address at a specific point in time
* Find all transactions for any address
* Find all transactions in a certain time period
* Find all transactions over a certain amount
* Find all transactions given a set of addresses


## What can you do with Toshi?

If you are a developer and want to start building bitcoin applications by querying blockchain data - you can use Toshi to do this.

### API
Toshi features a JSON API to query raw blockchain data.  You can read through the [API documentation](https://toshi.io/docs/).

![1](http://media.tumblr.com/8207cefbe1b6f1cdbccf5a448058475b/tumblr_inline_nc09ngpoLk1qh22ec.png)

Toshi provides access to raw blockchain data.  This allows you to do things like:
- read information about blocks, transactions, addresses, etc
- broadcast new transactions that you’ve generated to the network
- get stats on the blockchain like height and confirmation times


---

![2](http://media.tumblr.com/2f724007f796976d28a80c01cdc23cf7/tumblr_inline_nc09k9Uk791qh22ec.png)

---

## Usage

To access the **Toshi** interface, just click on the "See your Toshi instance running here!" link.

This container is prepared to start a Thoshi instance automatically, using the Terminal startup scripts.

On this case, Toshi is being launched into a (screen)[http://en.wikipedia.org/wiki/GNU_Screen] and it's live output can be examined by attaching the screen to a terminal tab by running `screen -x toshi`.


---

## Documentation
- [Toshi Main Website](https://toshi.io/)
- [Documentation](https://toshi.io/docs/)
- [GitHub Repo](https://github.com/coinbase/toshi)

---

### Additional Information

#### Toshi Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/toshi_installer.sh && bash toshi_installer.sh show`


---

#### Thanks for using Toshi at Terminal.com!
