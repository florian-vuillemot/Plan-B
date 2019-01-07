# Deploy GitLab and Jenkins on Azure

## Introduction

In this part we will show you how to automatically deploy your GitLab and your Jenkins VMs on Azure.
- GitLab configuration were extracted and adapt from official GitLab CE image on the Azure MarketPlace
- Jenkins configuration were extracted from official Jenkins image from Microsoft on the Azure MarketPlace

Note: We don't speak about the mail server here. You can found the documentation in the directory "postfix" at the root of the project.

## What you need

- Azure account
- Powershell (you can use Azure Cloud Shell)
- Powershell connect on your Azure account. If you use Azure Cloud Shell is not necessary, ELSE https://docs.microsoft.com/fr-fr/powershell/azure/authenticate-azureps?view=azps-1.0.0.

Note: All this scripts were tests from the Azure Cloud Shell.

## Deploy

1. Go this directory with you Powershell console
2. Deploy GitLab and Jenkins on Azure by running `pwsh main.ps1`

Take a coffee! This will take time. You can see infrastructure building from you Azure Portal.

3. Check that you infrastructure is up. For do this, go on Azure Portal > VMs > IP/DNS address

    3.1 For GitLab you should see first authentification parameters. You can configure your GitLab, is totally up and ready :)
  
    3.2 For Jenkins you should see a error with something like this 
  
      `This Jenkins instance does not support https, so logging in through a public IP address has been disabled (it would expose your password and other information to eavesdropping). To securely login, you need to connect to the Jenkins instance using SSH port forwarding.`
  
    Why this error message? For security reasons, Jenkins is allowing only local connection. For allow connection from Internet we will install a reverse proxy on the Jenkins machine.
  

4. Install HTTPS Reverse Proxy on Jenkins

    **Before continue.** This part is not perfect. We use a certificate auto signed. This will generate a big Warning on your navigator. In a production seniario you should use a real certificate. Moreover, you can create certificate with Azure thanks to Azure KeyVault.
    
    Nginx is ever present on the Jenkins machine. So we only need to configure Nginx for use HTTPS and make a redirection from the port 443 to 8080 (Jenkins port).
    
    Here we use certificate create with OpenSSL because we don't have domain name. Use LetsEncrypt or Azure KeyVault for create a real certificate :). Copy your `key` and your `crt` certificate for HTTPS on your Jenkins machine. Replace with your files naming. You should respect naming `certificate.[crt|key]` on the Jenkins VM.

    - `scp certificate.crt epitech@IP_ADDRESS:/home/epitech/`
    - `scp certificate.key epitech@IP_ADDRESS:/home/epitech/`

    After that run the script `azure/jenkins/install.sh` on the remote machine. From a powershell you can do `cat install.sh | ssh epitech@IP_ADDRESS 'bash -c'`.
    
    This script:
      - Obtain the Nginx and Jenkins configurations and erase the previous with there
      - Move the certificates files in the "good" directories for Nginx configurations
      - Restart Nginx and Jenkins daemons

## Improvement

1. Add/update HTTPS on your VM (use Letsencrypt, Azure with Azure Keyvault, etc...)

2. Make some backup. You can program back up automaticaly on Azure. Just follow this documentation. You can add back up in the scripts provide in this tutorial.

    Back up allow you to create the same machine in another region or Restore a VM after a crash. You can restore a VM directly from the Azure Portal.

    Doc:

        - https://docs.microsoft.com/en-us/azure/backup/quick-backup-vm-portal

        - https://docs.microsoft.com/en-us/azure/backup/backup-azure-arm-restore-vms

3. Disaster Recovery strategy. In case of disaster on a Azure datacenter you can switch on another region. I should do this for my school project. It's a little more complex that make backup.

    Microsoft provide a lot of documentation about DR. I choosed the simpliest strategy (it's not the better).

    Global vision: You need two Azure service. First **Azure DNS** for provide a entry point on your application. This service will route each user on the region up. Second you need **Azure Site Recovery** that make a copy of a resource group from a region to another region.

    Azure Site Recovery will not create another VM that run everytime. It will create another disk and synchronise it with the "master" disk. Same for the network. But Site Recovery not provide a public IP for the VM. So you should configure the Network for provide another **static** IP adresse on the second region that can be hit by Azure DNS.

    Summary steps:

        1. Give a public and Static IP at your VM.

        2. Go on "Disaster Recovery" in you VM action and configure it.

        3. When the other site is ready configure it by adding a static public IP at your VM.

        4. Use Azure DNS for route user on the site up.

    When a disaster happen, you should go on Azure Site Recovery and activate the "failover". This will create and configure a VM in the secondary region. After create the failover, go on Azure DNS and change the routing from your "prod" IP to the "dr" IP. That's done !
    
    VM provisioning take time and you should do this manually... So it's not perfect. But you have a cheap and functional DR strategy so it's a good point. Beside, don't forget that a DR plan is different of high disponibility.

    Doc:

        - https://docs.microsoft.com/en-us/azure/networking/disaster-recovery-dns-traffic-manager#manual-failover-using-azure-dns

        - https://docs.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-failover-failback

        - https://docs.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-enable-replication


5. Monitoring

    Monitoring is critical. You always want to know what's happening on your infrastructure. Moreover in case of disaster (point 4), only monitoring allow you reactivity.

    Monitoring on Azure is not trivial. I find it is difficult to learn. I had to read and re read the doc for understand that the best solution for this infrastuture is to use Agent on my Linux.

    Agent ? Microsoft create some program for help to monitore machine. A agent collect information about the machine (cpu/ram/disk...) and send it to Azure. Thanks to it you can show in the metric what's happend on you machine.

    On Linux, you should install the agent except if you use a image buidl by Microsoft (from the MarketPlace). Else go on https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/agent-linux#installation.
    
    When Agent is up you should go on you VM, Diagnostics settings and activate it. When is done go in Metrics and select the good metric namespace. You can now select more metrics.
    
    Don't forget to "pin" important metric on your Dashboards ;-)

    Note: Install agent only if you need it, don't spend time to install agent if you will not use it. For exemple, I will not manage my GitLab mail server (Postfix).


6. Alerting

    Monitoring is really importante. But you can go far with alerting ! Monitore what you need and add alert on everything. It's really easy and quick to create alert on Azure. Go on you VM > Monitoring > Alerts > Create. This alerting is trivial. But for starting and not important service this is perfect !
    
    If you have Agent install on your machine you can create "custom" alert base on the metrics. By custom I want to said, throw error when a metric is greater/lower of a value.
    
    For do this, go in Monitor > Alert > Manage alert rules > View classic alerts then fill field: subscription, Source, Resource Group, Resource type and Resource. When it's done click on "Add metric alert" and fill fields. This is 

    If you want do more and a powerful tools, you can show **OMS** that allow you to do amazing custom alert.
