# Deploy GitLab and Jenkins on Azure

## Introduction

In this part we will show you how to automatically deploy your GitLab and your Jenkins VMs on Azure.
- GitLab configuration were extracted and adapt from official GitLab CE image on the Azure MarketPlace
- Jenkins configuration were extracted from official Jenkins image from Microsoft on the Azure MarketPlace

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

    3.1 For GitLab you should see first authentification parameters. You can configure your GitLab, is totally up and ready :) -> If you want configure HTTPS on your machine, go part 5
  
    3.2 For Jenkins you should see a error with something like this 
  
      `This Jenkins instance does not support https, so logging in through a public IP address has been disabled (it would expose your password and other information to eavesdropping). To securely login, you need to connect to the Jenkins instance using SSH port forwarding.`
  
    Why this error message? For security reasons, Jenkins is allowing only local connection. For allow connection from Internet we will install a reverse proxy on the Jenkins machine.
  

4. Install HTTPS Reverse Proxy on Jenkins

    **Before continue.** This part is not perfect. We use a certificate auto signed. This will generate a big Warning on your navigator. In a production seniario you should use a real certificate. Moreover, you can create certificate with Azure thanks to Azure KeyVault.
    
    Nginx is ever present on the Jenkins machine. So we only need to configure Nginx for use HTTPS and make a redirection from the port 443 to 8080 (Jenkins port).
    
    Copy your `key` and your `crt` certificate for HTTPS on your Jenkins machine. Replace with your files naming. You should respect naming `certificate.[crt|key]` on the Jenkins VM.

    - `scp certificate.crt epitech@IP_ADDRESS:/home/epitech/`
    - `scp certificate.key epitech@IP_ADDRESS:/home/epitech/`

    After that run the script `azure/jenkins/install.sh` on the remote machine. From a powershell you can do `cat install.sh | ssh epitech@IP_ADDRESS 'bash -c'`.
    
    This script:
      - Obtain the Nginx and Jenkins configurations and erase the previous with there
      - Move the certificates files in the "good" directories for Nginx configurations
      - Restart Nginx and Jenkins daemons

5. Configure HTTPS on GitLab

  TODO
