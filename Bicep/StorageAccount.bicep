@description('Location for all resources.')
param ResourceLocation string

@description('The SKU of App Service Plan')
param sku string = 'F1'
var appServicePlanName = 'ASP${uniqueString(resourceGroup().id)}'

@description('For Appservice.')
param webSiteName string
param linuxFxVersion string
@description('Storage Account.')
@minLength(3)
@maxLength(6)
param storagePrefix string
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string
var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'

resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: uniqueStorageName
  location: ResourceLocation
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  tags: {
    'environment': 'devlopment'
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}
output StorageAccount string = uniqueStorageName

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: ResourceLocation
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
  tags: {
    'status': 'normal'
    'Team': 'cloud'
  }
}
output AppServicePlan string = appServicePlanName

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: ResourceLocation
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}
output Appservice string = webSiteName
