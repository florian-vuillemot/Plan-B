# This script create VM for GitLab and Jenkins
# For no overkill reasons we are not put the little conf allow in conf file
#

Import-Module $PSScriptRoot\vm_object.ps1;

# We use the same resource group location for GitLab and Jenkins
$resourceGroupLocation = "eastus";


function createResourceGroup([string]$resourceGroupName){
        New-AzureRmResourceGroup -Name $ResourceGroupName -Location $resourceGroupLocation;
}

function createVmFromUri([string]$resourceGroupName, [string]$templateUri, [string]$parametersUri){
         Write-Output $resourceGroupName;
         createResourceGroup($resourceGroupName);
         $vm = [Vm]::new($resourceGroupName, $templateUri, $parametersUri);
         $vm.CreateFromUri();
}

# Create GitLab
createVmFromUri "gitlab-rg" `
                "https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/gitlab/template.json" `
                "https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/gitlab/parameters.json"

# Create Jenkins
createVmFromUri "jenkins-rg" `
                "https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/jenkins/template.json" `
                "https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/jenkins/parameters.json"
