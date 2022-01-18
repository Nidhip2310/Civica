$subscriptionid = "6f936eff-fd4e-44d4-aaa1-13f5fd7d2472"

Set-AzContext -SubscriptionId $subscriptionid

New-AzResourceGroupDeployment `
    -Name Test `
    -ResourceGroupName test_ARM1 `
    -TemplateFile StorageAccount.bicep `
    -TemplateParameterFile StAccPara.json
