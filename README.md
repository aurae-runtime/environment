# Aurae

High level environment management for the Aurae runtime suite.

Use this repository to:
- develop against the suite.
- install the project toolchain into various Linux distributions.

If you are working directly with the aurae toolchain, or its source code you should probably start here.

## Installation

Currently the Aurae project is in alpha status and as such we do not yet support
package installations. Installation is done by installing the pre-requisites
and then compiling the project using the `rust` programming language.

### Dependencies

The Aurae environment depends on the `protoc` protocol buffer compiler being available within the path. 
Install `protoc` using your operating system's package manager (Or from source if you want to :) )
If you are running Ubuntu you can run the following,
```bash
sudo apt install -y protobuf-compiler
```

### Aurae Components

To install all Aurae components on a Linux distribution, run the following 
commands from within this repository:

```bash
make submodules # Please do not forget to do this!

# Then just follow a normal process
make 
make pki config # Generate certs and a default aurae config
make            # Compile and install aurae and auraed
```

Note that if you would like to do all of the above commands in one go you can also
run,
```bash 
make all
```

# Workflow

Open multiple tabs, or a tmux session, and in one start `auraed`,

```bash 
make start
```

In the other tab, you can then interact with `aurae` cli and `./scripts/`.

