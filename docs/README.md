# Aurae Documentation 



## System Defaults 

#### Client Environmental Variables

The `aurae` runtime recognizes the following environmental variables for clients

| Key              | Example Value                              | Description                                                        |
|------------------|--------------------------------------------|--------------------------------------------------------------------|
| AURAE_CLIENT_CRT | /etc/aurae/pki/_signed.client.nova.crt.pem | SSL Client Certificate for a user (nova), signed by the system CA. |
| AURAE_CLIENT_KEY | /etc/aurae/pki/client.nova.key.pem         | SSL Client Key for a user (nova).                                  |
| AURAE_ROOT_CA    | /etc/aurae/pki/ca.crt.pem                  | Root Certificate Authority. Certificate.                           |

#### PKI (Public Key Infrastructure)

Aurae leverages SSL certificates as its primary acd uthentication mechanism. Aurae holds SSL certificates as a primary source of authorization as a first principle.

The default directory for SSL certificate material on a Linux system:

```bash 
/etc/aurae/pki/*
```

