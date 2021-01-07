# Example of setting up an Nginx webserver on Ubuntu 20.04

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

3. Prepare a `vars.yml` file in the root directory to store secrets for the scripts. This file is git ignored. It should follow this template:

```yml
    ---
    alice_doe_pwd: "<value>"
    jim_doe_pwd: "<value>"
    sue_doe_ssh: "<value>"
    john_doe_ssh: "<value>"
```

## Usage

```sh
    ansible-playbook -i hosts -e @vars.yml setup-ubuntu.yml
```
