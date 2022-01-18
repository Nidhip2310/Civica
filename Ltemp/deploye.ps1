New-AzResourceGroupDeployment `
    -Name Test `
    -ResourceGroupName test_ARM1 `
    -TemplateFile .\linked.json `
    -TemplateParameterFile .\param.json