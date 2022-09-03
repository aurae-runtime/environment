# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
#         Apache 2.0 License Copyright (c) 2022-2023 The Aurae Authors         #
#                                                                              #
#                ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓                #
#                ┃  █████╗ ██╗   ██╗██████╗  █████╗ ███████╗  ┃                #
#                ┃  ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔════╝ ┃                #
#                ┃  ███████║██║   ██║██████╔╝███████║█████╗   ┃                #
#                ┃  ██╔══██║██║   ██║██╔══██╗██╔══██║██╔══╝   ┃                #
#                ┃  ██║  ██║╚██████╔╝██║  ██║██║  ██║███████╗ ┃                #
#                ┃  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ ┃                #
#                ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛                #
#                                                                              #
#                         Distributed Systems Runtime                          #
#                                                                              #
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
#                                                                              #
#   Licensed under the Apache License, Version 2.0 (the "License");            #
#   you may not use this file except in compliance with the License.           #
#   You may obtain headers-check copy of the License at                                    #
#                                                                              #
#       http://www.apache.org/licenses/LICENSE-2.0                             #
#                                                                              #
#   Unless required by applicable law or agreed to in writing, software        #
#   distributed under the License is distributed on an "AS IS" BASIS,          #
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
#   See the License for the specific language governing permissions and        #
#   limitations under the License.                                             #                                                                             #
#                                                                              #
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

default: submodule aurae auraed
all: default install

submodule: ## Initialize all submodules
	@echo "Initializing submodules"
	@git submodule update --init --recursive

.PHONY: aurae
aurae: ## Initialize and compile aurae
	cd aurae && make
	cp -v aurae/target/release/aurae bin


.PHONY: auraed
auraed: ## Initialize and compile auraed
	cd auraed && make
	cp -v auraed/target/release/auraed bin

install: ## Install (copy) to /bin
	chmod +x bin/*
	sudo -E cp -v bin/* /bin

.PHONY: clean
clean:
	cd aurae && make clean
	cd auraed && make clean
	@rm -rvf bin/*

headers: ## Update the headers for all submodules


headers-check: ## Update the headers for all submodules
	./hack/headers-check

update-headers: ## Update the headers in the repository. Required for all new files.
	./hack/headers-validate

.PHONY: help
help:  ## 🤔 Show help messages for make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'


