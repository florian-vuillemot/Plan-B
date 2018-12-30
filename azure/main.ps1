# This script create VM for GitLab and Jenkins
# For no overkill reasons we are not put the little conf allow in conf file
#

Import-Module $PSScriptRoot\t2.ps1

# We use the same resource group location for GitLab and Jenkins
$resourceGroupLocation = "eastus";


function createResourceGroup([string]$resourceGroupName){
        New-AzureRmResourceGroup -Name $ResourceGroupName -Location $resourceGroupLocation;
}

function createGitLab(){
         $gitlabResourceGroup = "gitlab-rg";

         createResourceGroup($gitLabResourceGroup);
         $gitlab = [Vm]::new($gitLabResourceGroup,
                            "https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/gitlab/template.json",
                            "https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/gitlab/parameters.json");

        $gitlab.CreateFromUri();
}

function createJenkins(){
         $jenkinsResourceGroup = "jenkins-rg";

         createResourceGroup($jenkinsResourceGroup);
         $jenkins = [Vm]::new($jenkinsResourceGroup,
                              "https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/jenkins/template.json",
                              "https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/jenkins/parameters.json");

        $jenkins.CreateFromUri();
}

createGitLab;
createJenkins;
