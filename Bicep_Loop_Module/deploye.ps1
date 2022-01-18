$subscriptionid =  Read-Host 'SubscriptionID :'
$location = Read-Host 'Location :'
$moduledepname = Read-Host 'Dept Resource name from module. :'

New-AzResourceGroupDeployment `
-subscriptionid $subscriptionid
-Name Test `
-ResourceGroupName test_ARM1 `
-TemplateFile ST.bicep `
-location $location `
-module $moduledepname
