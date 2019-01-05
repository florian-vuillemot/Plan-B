# Deploy PostFix mail server on a Centos 7 on Azure

## Introduction

Installation is in 3 parts

1. Create a Centos 7 VM on Azure

2. Install and configure SaltStack on the Centos 7 machine
    
3. Install and configure PostFix with SaltStack


#### Why SaltStack

Easy, scalable and powerful. Here we use only one capacity of SaltStack, we only deploy our infra. But in the future we could manage multiples VM with management of failures and DR. Moreover its a standalone technologie that we can use in a multi cloud strategy.

We also could use Docker. But Docker add an over layer and have a runtime cost. Here, this mail server will **only** be used with GitLab. So we don't need a big machine and we can use the smallest that Azure provide.

## Mandatory

- Azure account

- Powershell or Azure Cloud Shell

- A Linux configure with you Salt Master and a Public IP address. You can also install the Salt Master on the same machine that the Salt Minion. You will loose a lot of SaltStack functionality but, for this tutorial this is OK.


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


### Note

The SaltStack script were not build with a Azure Instance. It were build with a VM on Virtualbox. So if you execute the script on a Azure VM (as we explain in thie README) you will get some error with `firewall-cmd`. In this case is not a problem. Here, the job done by firewall-cmd is done by the ARM template that you execute for create the VM on Azure.

