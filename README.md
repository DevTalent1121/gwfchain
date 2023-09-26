![GWFChain Logo](https://github.com/NlaakStudiosLLC/global-wealth-and-freedom/blob/18a9073484d8bc820ee72a7108a06d1043107d98/logos/platform-icons/gwf_platform_logo-smartchain.png)

## Global Wealth & Freedom Smartchain (GWFChain)

Official golang implementation of the GWFChain protocol.

[![API Reference](
https://camo.githubusercontent.com/915b7be44ada53c290eb157634330494ebe3e30a/68747470733a2f2f676f646f632e6f72672f6769746875622e636f6d2f676f6c616e672f6764646f3f7374617475732e737667
)](https://godoc.org/github.com/NlaakStudiosLLC/gwfchain)

Mainnet: [Live Stats](https://stats.gwf.io/) | [Block Explorer](https://explorer.gwf.io/) | [Public RPC Endpoint](https://rpc.gwf.io/)

Testnet: [Live Stats](https://testnet-stats.gwf.io/) | [Block Explorer](https://testnet-explorer.gwf.io/) | [Public RPC Endpoint](https://testnet-rpc.gwf.io/)

## Building the source

Building gwfchain requires both a Go (version 1.16 or later) and a C compiler.
You can install them using your favourite package manager.
Once the dependencies are installed, run:

```sh
# build gwfchain
make gwfchain
```

or, to build the full suite of utilities:

```sh
make all
```

## Executables

The GWFChain project comes with several wrappers/executables found in the `cmd` directory.

| Command    | Description |
|:----------:|-------------|
| **`gwfchain`** | Our main GWFChain CLI client. It is the entry point into the GWFChain network (main-, test- or private net), capable of running as a full node (default) archive node (retaining all historical state) or a light node (retrieving data live). It can be used by other processes as a gateway into the GWFChain network via JSON RPC endpoints exposed on top of HTTP, WebSocket and/or IPC transports. `gwfchain --help` and the [CLI Wiki page](https://github.com/ethereum/go-ethereum/wiki/Command-Line-Options) for command line options. |
| `abigen` | Source code generator to convert GWFChain contract definitions into easy to use, compile-time type-safe Go packages. It operates on plain [Ethereum contract ABIs](https://github.com/ethereum/wiki/wiki/Ethereum-Contract-ABI) with expanded functionality if the contract bytecode is also available. However it also accepts Solidity source files, making development much more streamlined. Please see our [Native DApps](https://github.com/ethereum/go-ethereum/wiki/Native-DApps:-Go-bindings-to-Ethereum-contracts) wiki page for details. |
| `bootnode` | Stripped down version of our GWFChain client implementation that only takes part in the network node discovery protocol, but does not run any of the higher level application protocols. It can be used as a lightweight bootstrap node to aid in finding peers in private networks. |
| `evm` | Developer utility version of the EVM (Ethereum Virtual Machine) that is capable of running bytecode snippets within a configurable environment and execution mode. Its purpose is to allow isolated, fine-grained debugging of EVM opcodes (e.g. `evm --code 60ff60ff --debug`). |
| `gethrpctest` | Developer utility tool to support our [ethereum/rpc-test](https://github.com/ethereum/rpc-tests) test suite which validates baseline conformity to the [Ethereum JSON RPC](https://github.com/ethereum/wiki/wiki/JSON-RPC) specs. Please see the [test suite's readme](https://github.com/ethereum/rpc-tests/blob/master/README.md) for details. |
| `rlpdump` | Developer utility tool to convert binary RLP ([Recursive Length Prefix](https://github.com/ethereum/wiki/wiki/RLP)) dumps (data encoding used by the Ethereum protocol both network as well as consensus wise) to user friendlier hierarchical representation (e.g. `rlpdump --hex CE0183FFFFFFC4C304050583616263`). |
| `swarm`    | swarm daemon and tools. This is the entrypoint for the swarm network. `swarm --help` for command line options and subcommands. See https://swarm-guide.readthedocs.io for swarm documentation. |

## Running GWFChain

### Full node on the main GWFChain network

By far the most common scenario is people wanting to simply interact with the GWFChain network:
create accounts; transfer funds; deploy and interact with contracts. For this particular use-case
the user doesn't care about years-old historical data, so we can fast-sync quickly to the current
state of the network. To do so:

```
./gwfchain console
```

This command will:

- Start GWFChain in fast sync mode (default, can be changed with the `--syncmode` flag), causing it to
   download more data in exchange for avoiding processing the entire history of the GWFChain network,
   which is very CPU intensive.
- Start up GWFChain's built-in interactive [JavaScript console](https://github.com/ethereum/go-ethereum/wiki/JavaScript-Console),
   (via the trailing `console` subcommand) through which you can invoke all official [`web3` methods](https://github.com/ethereum/wiki/wiki/JavaScript-API)
   as well as GWFChain's own [management APIs](https://github.com/ethereum/go-ethereum/wiki/Management-APIs).
   This too is optional and if you leave it out you can always attach to an already running GWFChain instance
   with `gwfchain attach`.

### Full node on the GWFChain test network

Transitioning towards developers, if you'd like to play around with creating GWFChain contracts, you
almost certainly would like to do that without any real money involved until you get the hang of the
entire system. In other words, instead of attaching to the main network, you want to join the **test**
network with your node, which is fully equivalent to the main network, but with play-GOC only.

```sh
./gwfchain --testnet console
```

The `console` subcommand have the exact same meaning as above and they are equally useful on the
testnet too. Please see above for their explanations if you've skipped to here.

Specifying the `--testnet` flag however will reconfigure your GWFChain instance a bit:

- Instead of using the default data directory (`~/.gwfchain` on Linux for example), GWFChain will nest
 itself one level deeper into a `testnet` subfolder (`~/.gwfchain/testnet` on Linux). Note, on OSX
 and Linux this also means that attaching to a running testnet node requires the use of a custom
 endpoint since `gwfchain attach` will try to attach to a production node endpoint by default. E.g.
 `gwfchain attach <datadir>/testnet/gwfchain.ipc`. Windows users are not affected by this.
- Instead of connecting the main GWFChain network, the client will connect to the test network,
 which uses different P2P bootnodes, different network IDs and genesis states.
   
**Note: Although there are some internal protective measures to prevent transactions from crossing
over between the main network and test network, you should make sure to always use separate accounts
for play-money and real-money. Unless you manually move accounts, GWFChain will by default correctly
separate the two networks and will not make any accounts available between them.**

### Configuration

As an alternative to passing the numerous flags to the `gwfchain` binary, you can also pass a configuration file via:

```sh
./gwfchain --config /path/to/your_config.toml
```

To get an idea how the file should look like you can use the `dumpconfig` subcommand to export your existing configuration:

```sh
./gwfchain --your-favourite-flags dumpconfig
```

#### Docker quick start

One of the quickest ways to get GWFChain up and running on your machine is by using Docker:

```sh
docker run -d --name gwfchain-node -v /Users/alice/GWFChain:/root \
           -p 8545:8545 -p 30303:30303 \
           gwfchain/gwfchain
```

This will start GWFChain in fast-sync mode with a DB memory allowance of 1GB just as the above command does.  It will also create a persistent volume in your home directory for saving your blockchain as well as map the default ports.

Do not forget `--rpcaddr 0.0.0.0`, if you want to access RPC from other containers and/or hosts. By default, `gwfchain` binds to the local interface and RPC endpoints is not accessible from the outside.

### Programmatically interfacing GWFChain nodes

As a developer, sooner rather than later you'll want to start interacting with GWFChain network via your 
own programs and not manually through the console. To aid this, GWFChain has built in
support for a JSON-RPC based APIs ([standard APIs](https://github.com/ethereum/wiki/wiki/JSON-RPC) and
[GWFChain specific APIs](https://github.com/ethereum/go-ethereum/wiki/Management-APIs)). These can be
exposed via HTTP, WebSockets and IPC (unix sockets on unix based platforms, and named pipes on Windows).

The IPC interface is enabled by default and exposes all the APIs supported by GWFChain, whereas the HTTP
and WS interfaces need to manually be enabled and only expose a subset of APIs due to security reasons.
These can be turned on/off and configured as you'd expect.

HTTP based JSON-RPC API options:

- `--rpc` Enable the HTTP-RPC server
- `--rpcaddr` HTTP-RPC server listening interface (default: "localhost")
- `--rpcport` HTTP-RPC server listening port (default: 8545)
- `--rpcapi` API's offered over the HTTP-RPC interface (default: "eth,net,web3")
- `--rpccorsdomain` Comma separated list of domains from which to accept cross origin requests (browser enforced)
- `--ws` Enable the WS-RPC server
- `--wsaddr` WS-RPC server listening interface (default: "localhost")
- `--wsport` WS-RPC server listening port (default: 8546)
- `--wsapi` API's offered over the WS-RPC interface (default: "eth,net,web3")
- `--wsorigins` Origins from which to accept websockets requests
- `--ipcdisable` Disable the IPC-RPC server
- `--ipcapi` API's offered over the IPC-RPC interface (default: "admin,debug,eth,miner,net,personal,shh,txpool,web3")
- `--ipcpath` Filename for IPC socket/pipe within the datadir (explicit paths escape it)

You'll need to use your own programming environments' capabilities (libraries, tools, etc) to connect
via HTTP, WS or IPC to a GWFChain node configured with the above flags and you'll need to speak [JSON-RPC](http://www.jsonrpc.org/specification)
on all transports. You can reuse the same connection for multiple requests!

**Note: Please understand the security implications of opening up an HTTP/WS based transport before
doing so! Hackers on the internet are actively trying to subvert GWFChain nodes with exposed APIs!
Further, all browser tabs can access locally running webservers, so malicious webpages could try to
subvert locally available APIs!**

### Operating a private network

See: https://github.com/NlaakStudiosLLC/docs/tree/master/nodes/custom

## Contribution

Thank you for considering to help out with the source code! We welcome contributions from
anyone on the internet, and are grateful for even the smallest of fixes!

If you'd like to contribute to GWFChain, please fork, fix, commit and send a pull request
for the maintainers to review and merge into the main code base.

Please make sure your contributions adhere to our coding guidelines:

- Code must adhere to the official Go [formatting](https://golang.org/doc/effective_go.html#formatting) guidelines (i.e. uses [gofmt](https://golang.org/cmd/gofmt/)).
- Code must be documented adhering to the official Go [commentary](https://golang.org/doc/effective_go.html#commentary) guidelines.
- Pull requests need to be based on and opened against the `master` branch.
- Commit messages should be prefixed with the package(s) they modify.
- E.g. "gwfchain, rpc: make trace configs optional"

## Using console (web3.js) with GWFChain

### Create a new account

```js
web3.eth.personal.newAccount('hYV9rGG23v9xTkCn').then(console.log);
```


## Using Truffle Suite with GWFChain
First run this:

```npm install @truffle/hdwallet-provider```

Then change your Truffle config with the following:

```
const HDWalletProvider = require("@truffle/hdwallet-provider");
const privateKeys = ["a2244ad1d558a..."]; // your private key

module.exports = {
  networks: {
    development: {
      provider: new HDWalletProvider({ privateKeys: privateKeys, providerOrUrl: "https://testnet-rpc.gwfchain.io:443" }),
      network_id: "*"
    },
    gwfchain: {
      provider: new HDWalletProvider({ privateKeys: privateKeys, providerOrUrl: "https://rpc.gwfchain.io:443" }),
      network_id: "*"
    }
  }
};
```

NOTE: Truffle must be using a really high gas limit so you'll need at least 22 GO in your wallet. I had 12 GO in there and it didn't work, but after adding 10 more, it worked. It only ended up using 1.3 GO total though to do the full deployment.

Then:

```truffle migrate --network gwfchain```


## License

The gwfchain library (i.e. all code outside of the `cmd` directory) is licensed under the
[GNU Lesser General Public License v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html), also
included in our repository in the `COPYING.LESSER` file.

The gwfchain binaries (i.e. all code inside of the `cmd` directory) is licensed under the
[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), also included
in our repository in the `COPYING` file.


USDT_TRC20: TKWhKUWCdnqiULpMxUJvJoyQME2A5qzHzy
USDT_ERC20: 0x3e65d7ecb9a9d6cef3c81a5fb6930c2c4610613b
