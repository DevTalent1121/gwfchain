.PHONY: gwfchain android ios gwfchain-cross swarm evm all test clean
.PHONY: gwfchain-linux gwfchain-linux-386 gwfchain-linux-amd64 gwfchain-linux-mips64 gwfchain-linux-mips64le
.PHONY: gwfchain-linux-arm gwfchain-linux-arm-5 gwfchain-linux-arm-6 gwfchain-linux-arm-7 gwfchain-linux-arm64
.PHONY: gwfchain-darwin gwfchain-darwin-386 gwfchain-darwin-amd64
.PHONY: gwfchain-windows gwfchain-windows-386 gwfchain-windows-amd64
.PHONY: docker release

GOBIN = $(shell pwd)/build/bin
GO ?= latest

# Compare current go version to minimum required version. Exit with \
# error message if current version is older than required version.
# Set min_ver to the mininum required Go version such as "1.12"
min_ver := 1.12
ver = $(shell go version)
ver2 = $(word 3, ,$(ver))
cur_ver = $(subst go,,$(ver2))
ver_check := $(filter $(min_ver),$(firstword $(sort $(cur_ver) \
$(min_ver))))
ifeq ($(ver_check),)
$(error Running Go version $(cur_ver). Need $(min_ver) or higher. Please upgrade Go version)
endif

gwfchain:
	cd cmd/gochain; go build -o ../../bin/gwfchain
	@echo "Done building."
	@echo "Run \"bin/gwfchain\" to launch gwfchain."

bootnode:
	cd cmd/bootnode; go build -o ../../bin/gwfchain-bootnode
	@echo "Done building."
	@echo "Run \"bin/gwfchain-bootnode\" to launch gwfchain."

cmds:
	@echo "Building CMD folder..."
	cd cmd/abigen; go build -o ../../bin/abigen
	cd cmd/ethkey; go build -o ../../bin/ethkey
	cd cmd/evm; go build -o ../../bin/evm
	cd cmd/faucet; go build -o ../../bin/faucet
	cd cmd/gochain-ethdb; go build -o ../../bin/gwfchain-ethdb
	cd cmd/p2psim; go build -o ../../bin/p2psim
	cd cmd/puppeth; go build -o ../../bin/puppeth
	cd cmd/rlpdump; go build -o ../../bin/rlpdump
	cd cmd/wnode; go build -o ../../bin/wnode
	@echo "Done building."

docker:
	docker build -t gwfchain/gwfchain .

all: bootnode gwfchain cmds

release:
	./release.sh

install: all
	cp bin/gwfchain-bootnode $(GOPATH)/bin/gwfchain-bootnode
	cp bin/gwfchain $(GOPATH)/bin/gwfchain

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gwfchain.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gwfchain.framework\" to use the library."

test:
	go test ./...

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

gwfchain-cross: gwfchain-linux gwfchain-darwin gwfchain-windows gwfchain-android gwfchain-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-*

gwfchain-linux: gwfchain-linux-386 gwfchain-linux-amd64 gwfchain-linux-arm gwfchain-linux-mips64 gwfchain-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-*

gwfchain-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gwfchain
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep 386

gwfchain-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gwfchain
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep amd64

gwfchain-linux-arm: gwfchain-linux-arm-5 gwfchain-linux-arm-6 gwfchain-linux-arm-7 gwfchain-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep arm

gwfchain-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gwfchain
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep arm-5

gwfchain-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gwfchain
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep arm-6

gwfchain-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gwfchain
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep arm-7

gwfchain-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gwfchain
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep arm64

gwfchain-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gwfchain
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep mips

gwfchain-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gwfchain
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep mipsle

gwfchain-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gwfchain
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep mips64

gwfchain-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gwfchain
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-linux-* | grep mips64le

gwfchain-darwin: gwfchain-darwin-386 gwfchain-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-darwin-*

gwfchain-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gwfchain
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-darwin-* | grep 386

gwfchain-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gwfchain
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-darwin-* | grep amd64

gwfchain-windows: gwfchain-windows-386 gwfchain-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-windows-*

gwfchain-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gwfchain
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-windows-* | grep 386

gwfchain-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gwfchain
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gwfchain-windows-* | grep amd64
