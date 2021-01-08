# Example of setting up an Nginx webserver on Ubuntu 20.04

## Disclaimer

* This is a WIP PoC. Not all roles work completely.
* Secrets are stored in plaintext. I know that this should never be happening. I don't have experience handling secrets with Ansible. Based on my research Ansible Vault should be used for encrypting data at rest https://docs.ansible.com/ansible/latest/user_guide/vault.html#vault and the `no_log` option should be used to avoid disclosing secrets used in playbooks.
* I don't have a lot of experience with Linux roles and I'm not entirely certain that ownership of certain directories is set correctly.
* When it comes to scripts generating pages - maybe Bash isn't the most elegant way to do it, but I found it the fastest to gather the data required.

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

The `hosts` file depends on `ubuntu` hostname, so feel free to adjust it as needed.

3. Prepare a `vars.yml` file in the root directory to store secrets for the scripts. This file is git ignored. It should follow this template:

```yml
    ---
    alice_doe_pwd: "<value>"
    jim_doe_pwd: "<value>"
    slack_webhook: "<value>"
```

> Note: Slack webhook is optional. Remove pre- and post- tasks if you don't want to use it.
> To run the playbook in check mode, you'll need to comment out the pre- and post- tasks.

4. Prepare SSH key files. They should be named `john.doe` and `sue.doe` and are expected to be stored in root directory. The are added to `.gitignore`.


## Usage

Run the play:

```sh
    make run
```

To run the play in `check` mode, comment our the pre- and post- tasks (otherwise the play fails of `whoami` command) and run:

```sh
    make dry-run
```

## TODO

There are a few outstanding tasks I didn't manage to get to:

### Installing Docker

I haven't managed to complete that. When trying to add the Docker repository, I ran into this error:

```txt
    "E:Malformed entry 1 in list file /etc/apt/sources.list.d/download_docker_com_linux_ubuntu_focal_stable.list (Suite), E:The list of sources could not be read."
```

I've been following the official Docker guide https://docs.docker.com/engine/install/ubuntu/ when that happened. I should do more research and figure out what's going on.

### Setting up a reverse proxy

I believe that in order to expose a content from a Docker container on a specific path, it will require setting up a reverse proxy with Nginx and Docker Compose. I found multiple guides on how to do it, including https://dzone.com/articles/how-to-nginx-reverse-proxy-with-docker-compose

Since I haven't been able to finish installing Docker completely, and haven't had a chance to play with Docker Compose in the past, I threw in a towel here for now.

### Setting up HTTPS

I think there are two ways to do it:

1. Locally generate a certificate, copy it to the host machine and modify the Nginx config to setup redirects. I found these materials on how to do it:

* https://letsencrypt.org/docs/certificates-for-localhost/
* http://nginx.org/en/docs/http/configuring_https_servers.html

2. I've read that it's possible to setup Certbot to automatically renew certificates on the host machine. I never had a need to do it, but I'd prefer that way as it minimizes the toil related to certificate rotation. E.g.:

* https://www.digitalocean.com/community/tutorials/how-to-set-up-let-s-encrypt-with-nginx-server-blocks-on-ubuntu-16-04
