# Deploy PostFix mail server on a Centos 7 on Azure

## Introduction

Installation is in 3 parts

1. Create a Centos 7 VM on Azure

2. Install and configure SaltStack on the Centos 7 machine
    
3 Install and configure PostFix with SaltStack



## Mandatory

- Azure account

- Powershell or Azure Cloud Shell

- A Linux configure with you Salt Master and a Public IP address


## Steps

1. Create a CentOS VM on Azure

After being authentificate run `pwsh create_centos.ps1`.

This will create a Resource Group 'postfix-rg' with a CentOS 7 VM, subnet, etc...


2. Install and configure SaltStack on the Centos 7 machine


Go on this machine with SSH and install a SaltStack Minion (https://repo.saltstack.com/#rhel). After that indicate the Master IP Address on you Salt-Minion (file /etc/salt/minion).

    
3. Install and configure PostFix with SaltStack


Add the Salt-Minion on the Salt-Master with Salt-key.

Configure you Salt Master for run the state of this directory. Or create a symlink from you `/srv` on this repository for obtain the output of the `init.sls` from the command `cat /srv/salt/top.sls`.
    
Run the installation with `salt 'centos-vm' state.apply`.

