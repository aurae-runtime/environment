# ---------------------------------------------------------------------------- #
#             Apache 2.0 License Copyright © 2022 The Aurae Authors            #
#                                                                              #
#                +--------------------------------------------+                #
#                |   █████╗ ██╗   ██╗██████╗  █████╗ ███████╗ |                #
#                |  ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔════╝ |                #
#                |  ███████║██║   ██║██████╔╝███████║█████╗   |                #
#                |  ██╔══██║██║   ██║██╔══██╗██╔══██║██╔══╝   |                #
#                |  ██║  ██║╚██████╔╝██║  ██║██║  ██║███████╗ |                #
#                |  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ |                #
#                +--------------------------------------------+                #
#                                                                              #
#                         Distributed Systems Runtime                          #
#                                                                              #
# ---------------------------------------------------------------------------- #
#                                                                              #
#   Licensed under the Apache License, Version 2.0 (the "License");            #
#   you may not use this file except in compliance with the License.           #
#   You may obtain a copy of the License at                                    #
#                                                                              #
#       http://www.apache.org/licenses/LICENSE-2.0                             #
#                                                                              #
#   Unless required by applicable law or agreed to in writing, software        #
#   distributed under the License is distributed on an "AS IS" BASIS,          #
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
#   See the License for the specific language governing permissions and        #
#   limitations under the License.                                             #
#                                                                              #
# ---------------------------------------------------------------------------- #

subbranch   =  main

default: all
all: install

update: ## Update rustup (nightly)
	rustup update

status: ## Wrapper for git status
	git status

pull: ## Pull all the submodules from origin main
	cd aurae && git pull origin $(subbranch)
	cd auraed && git pull origin $(subbranch)
	cd api && git pull origin $(subbranch)
	cd scripts && git pull origin $(subbranch)

submodules: submodule ## Nobody is perfect, and git submodules are hard enough without having to remember to use the "s" or not.
submodule: ## Initialize all submodules
	@echo "Initializing submodules"
	@echo ""
	@read -p "Warning: This will destroy all work in subdirectories! Press any key to continue."

	# Aurae
	@if [ -d /tmp/aurae ]; then rm -rvf /tmp/aurae; fi
	@if [ -d aurae ]; then mv -v aurae /tmp/aurae; fi

	# Auraed
	@if [ -d /tmp/auraed ]; then rm -rvf /tmp/auraed; fi
	@if [ -d auraed ]; then mv -v auraed /tmp/auraed; fi

	# API
	@if [ -d /tmp/api ]; then rm -rvf /tmp/api; fi
	@if [ -d api ]; then mv -v api /tmp/api; fi

	# Scripts
	@if [ -d /tmp/scripts ]; then rm -rvf /tmp/scripts; fi
	@if [ -d scripts ]; then mv -v scripts /tmp/scripts; fi

	# Init and update
	@git submodule update --init --recursive
	@git submodule update --remote --rebase

	# Attach to main
	cd aurae && git checkout $(subbranch) && git branch && git pull origin $(subbranch)
	cd auraed && git checkout $(subbranch) && git branch && git pull origin $(subbranch)
	cd api && git checkout $(subbranch) && git branch && git pull origin $(subbranch)
	cd scripts && git checkout $(subbranch) && git branch && git pull origin $(subbranch)

.PHONY: config
config: ## Set up default config
	sudo -E cp -v aurae/default.config.toml /etc/aurae/config

.PHONY: pki
pki: certs ## Alias for certs
certs: clean-certs ## Generate x509 mTLS certs in /pki directory
	./hack/certgen

clean-certs: ## Clean the cert material
	@rm -rvf pki/*

key: keygen ## Alias for keygen
keygen: ## Generate an SSH key for aurae: id_aurae
	ssh-keygen -t ed25519 -a 1337 -f $(HOME)/.ssh/id_aurae

.PHONY: aurae
aurae: ## Initialize and compile aurae
	@if [ ! -d aurae ]; then printf "\n\nError: Missing submodules. Run 'make submodule' to download aurae source before compiling.\n\n"; exit 1; fi
	cd aurae && make install
	cp -v aurae/target/release/aurae target

.PHONY: auraed
auraed: ## Initialize and compile auraed
	@if [ ! -d auraed ]; then printf "\n\nError:\nun 'make submodule' to download auraed source before compiling.\n\n"; exit 1; fi
	cd auraed && make install
	cp -v auraed/target/release/auraed target

install: config ## Install (copy) to /bin
	cd aurae && make install
	cd auraed && make install
	#sudo -E cp -v target/* /bin
	sudo -E mkdir -p /etc/aurae/pki
	sudo -E cp pki/* /etc/aurae/pki
	@echo "Install PKI Auth Material"

fmt: headers ## Format the entire code base(s)
	@./hack/code-format

.PHONY: clean
clean: clean-certs
	cd aurae && make clean
	cd auraed && make clean
	@rm -rvf target/*

headers: headers-write ## Fix headers. Run this if you want to clobber things.

headers-check: ## Only check for problematic files.
	./hack/headers-check

headers-write: ## Fix any problematic files blindly.
	./hack/headers-write

.PHONY: help
help:  ## 🤔 Show help messages for make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-30s[0m %s", $$1, $$2}'
