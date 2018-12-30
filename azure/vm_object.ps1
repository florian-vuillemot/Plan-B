class Vm
{
        [string] $ResourceGroupName;
        [string] $TemplatePath;
        [string] $TemplateParameterPath;

        Vm([string]$rg, [string]$tf, [string]$tp){
                $this.ResourceGroupName = $rg;
                $this.TemplatePath = $tf;
                $this.TemplateParameterPath = $tp;
        }

        [bool] Create(){
                $res = New-AzureRmResourceGroupDeployment -ResourceGroupName $this.ResourceGroupName `
                                                          -TemplateFile $this.TemplatePath `
                                                          -TemplateParameterFile $this.TemplateParameterPath;
                return 1;
        }

        [bool] CreateFromUri(){
                $res = New-AzureRmResourceGroupDeployment -ResourceGroupName $this.ResourceGroupName `
                                                          -TemplateUri $this.TemplatePath `
                                                          -TemplateParameterUri $this.TemplateParameterPath;
                return 1;
        }
}

