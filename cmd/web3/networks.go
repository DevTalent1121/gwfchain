package web3

import "math/big"

const (
	testnetExplorerURL = "https://testnet-explorer.gwf.io/api"
	mainnetExplorerURL = "https://explorer.gwf.io/api"
	testnetURL         = "https://testnet-rpc.gwf.io"
	mainnetURL         = "https://rpc.gwf.io"
)

var Networks = map[string]Network{
	"testnet": {
		Name:        "testnet",
		URL:         testnetURL,
		ChainID:     big.NewInt(31337),
		Unit:        "GWFU",
		ExplorerURL: testnetExplorerURL,
	},
	"gwfchain": {
		Name:        "gwfchain",
		URL:         mainnetURL,
		ChainID:     big.NewInt(60),
		Unit:        "GWFU",
		ExplorerURL: mainnetExplorerURL,
	},
	"localhost": {
		Name: "localhost",
		URL:  "http://localhost:8545",
		Unit: "GWFU",
	},
	"ethereum": {
		Name: "ethereum",
		URL:  "https://mainnet.infura.io/v3/bc5b0e5cfd9b4385befb69a68a9400c3",
		// URL: "https://cloudflare-eth.com", // these don't worry very well, constant problems
		// URL: "https://main-rpc.linkpool.io",
		ChainID:     big.NewInt(1),
		Unit:        "ETH",
		ExplorerURL: "https://etherscan.io",
	},
	"ropsten": {
		Name:    "ropsten",
		URL:     "https://ropsten-rpc.linkpool.io",
		ChainID: big.NewInt(3),
		Unit:    "ETH",
	},
}

type Network struct {
	Name        string
	URL         string
	ExplorerURL string
	Unit        string
	ChainID     *big.Int
}
