# Aurae Installer and Builder Environment

Meta level installer for the Aurae runtime suite. Use this to develop against the suite. Use this to install the project toolchain into various Linux distributions.

### Compiling and Installing

All Aurae projects follow the `make` and `make install` convention. This is just a global wrapper for all of them.

To install everything Aurae on a Linux distribution run the following from this repository

```bash
make 
sudo -E make install
```

