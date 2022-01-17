New-AzResourceGroupDeployment `
    -Name Test `
    -ResourceGroupName test_ARM1 `
    -TemplateFile .\main.json `
    -TemplateParameterFile .\param.json