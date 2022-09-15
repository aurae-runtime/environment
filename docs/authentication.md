# Authentication 

Aurae uses mTLS to authenticate against the unix domain socket running locally.

### Socket Information

By default the `auraed` will set the permissions to `0766` for the socket. This will allow non-root users to read/write against the socket.

```
/var/run/aurae/aurae.sock
```

Authentication is enforced by mTLS, and not by file permissions.

### Generating PKI Locally

We suggest maintaining your own PKI management process.

For now, you can leverage the Makefile in this repository to
generate mTLS material for you to test with.

```
make pki config
```

This will generate new certs and install them to the following directories.

```
/etc/aurae/pki
${HOME}/.aurae/pki
```

The local daemon will leverage the material in `/etc/aurae` while your local user will leverage the material in your `${HOME}` directory.

### Server Certs


### Client Certs

``` 
curl --cacert ./ca.crt https://client.nova.unsafe.aurae.io:8080 -H client.nova.unsafe.aurae.io --resolve client.nova.unsafe.aurae.io:8080:127.0.0.1 --cert ./_signed.client.unsafe.crt --key ./client.unsafe.key -v > /dev/null
```
