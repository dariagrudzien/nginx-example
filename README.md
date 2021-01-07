# Example of setting ub an Nginx webserver on Ubuntu 20.04

## Prerequisites

1. Publicly available Ubuntu host that you can ssh into
2. Updated ssh config. I recommend adding this line into your `~/.ssh/config` file:

```sh
    Host ubuntu
        User ubuntu
        Port 22
        Hostname <IP of the host>
        IdentityFile <path to the private key matching the key on the host, e.g. ~/.ssh/id_rsa>
```
