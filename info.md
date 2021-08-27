# GWF Smartchain (forked from gwfchain)

## Ports:
- mainnet: 1969
- testnet: 9691

## Data Directory (default)
- Darwin (MAC) -> Library/GWFChain
- Windows -> home/AppData/Roaming/GWFChain
- Linux -> home/.gwfchain

## Start Node
```bash
./gwfchain --datadir "./node/" --networkid 1969 --rpc --ws --nat extip:104.54.160.95
```

## Deployables
All deployable via jenkins push to main/master

### Blockchain
- Domain: https://chain.gwf.io
- Repo: https://github.com/NlaakStudiosLLC/gwfchain
- Open Port(s): 1969/9691
- Also open https://rpc.gwf.io to Blockchain RPC Port 8545
- And open https://ws.gwf.io to block chain Websocket Port 8546
### Blockchain Explorer
- Domain: https://explorer.gwf.io
- Repo: https://github.com/NlaakStudiosLLC/explorer2020
- Open Port(s): 80

### Blockchain NetStats
- Domain: https://stats.gwf.io
- Repo: https://github.com/NlaakStudiosLLC/netstats
- Open Port(s): 80

## Connecting MetaMask
TODO

## 