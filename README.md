# OpenVPN Ansible playbooks

This repository contains Ansible playbooks for the automated deployment and management of an OpenVPN server.

# Table of contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Important Note](#important-note)
- [License](#license)

## Overview
The playbooks in this repository provide a complete automation solution for setting up and managing an OpenVPN server. The suite of scripts handles installation, configuration, and user management, thereby simplifying the server setup process. Additionally, it encapsulates EasyRSA in a Docker container for efficient public key infrastructure (PKI) management.

# Requirements
* Python3
* Pipenv
* Docker
* Server running Debian or Ubuntu.

## Installation
Clone the repository:
```bash
git clone https://github.com/ggragham/openvpn_deploy.git
```
Navigate into the repository directory:
```bash
cd openvpn_deploy/
```
Install Ansible and dependencies using Pipenv:
```bash
pipenv install
```

## Configuration
Fill **inventory.yml** and **vars.yml** from templates:
```bash
cp ansible/inventory.yml.template ansible/inventory.yml
edit ansible/inventory.yml
cp ansible/vars.yml.template ansible/vars.yml
edit ansible/vars.yml
```

## Usage
Before running the playbooks, ensure that your Pipenv virtual environment is active:
```bash
pipenv shell
```
Navigate into the ansible directory:
```bash
cd ansible/
```
To deploy an OpenVPN server, use the following command:
```bash
ansible-playbook openvpn_deploy.yml
```
For client management, use the corresponding playbook:
* To add a client:
```bash
ansible-playbook openvpn_gen_client.yml -e "client_name=<name>"
```
* To revoke a client:
```bash
ansible-playbook openvpn_revoke_client.yml -e "client_name=<name>"
```
## Important Note
Don't forget to back up your configuration files and PKI information regularly. This will ensure that you can recover your OpenVPN server setup in case of unforeseen issues. The responsibility for maintaining backups lies with the user.

# License
This software is published under the GPL-3.0 License license.