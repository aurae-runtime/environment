# Aurae Installer and Builder Environment

High level environment management for the Aurae runtime suite. Use this to develop against the suite. Use this to install the project toolchain into various Linux distributions.

If you are working directly with the aurae toolchain, or its source code you should probably start here.

### Compiling and Installing

All Aurae projects follow the `make` and `make install` convention. This is just a global wrapper for all of them.

To install everything Aurae on a Linux distribution run the following from this repository

```bash

make submodules # Please do not forget to do this!

# Then just follow a normal process
make 
sudo -E make install

```

Or a wrapper for everything

```bash 
make all
```

