//Loop with array (Storage Account 1 & 2)
//Resource Group: test_ARM1

param location string
param uniqueStorageName1 string = 'st1${uniqueString(resourceGroup().id)}'
param uniqueStorageName2 string = 'st2${uniqueString(resourceGroup().id)}'

param completestorageAccounts array = [
  {
    name: uniqueStorageName1
    location: location
    sku: {
      name: 'Standard_LRS'
    }
    kind: 'StorageV2'
    properties: {
      supportsHttpsTrafficOnly: true
      minimumTlsVersion: 'TLS1_2'
    }
  }
  {
    name: uniqueStorageName2
    location: location
    sku: {
      name: 'Premium_LRS'
    }
    kind: 'StorageV2'
    properties: {
      supportsHttpsTrafficOnly: true
      minimumTlsVersion: 'TLS1_0'
    }
  }
]

resource completearrayStas 'Microsoft.Storage/storageAccounts@2021-04-01' = [for sta in completestorageAccounts: {
  name: sta.name
  location: sta.location  
  sku: sta.sku
  kind: 'StorageV2'
  properties: sta.properties
  tags: {
    'environment': 'development'
  }
}]


//Creating module : Nested
param r string = 'RG01'
param moduledepname string

module stgModule '../Bicep/StorageAccount.bicep' = {
  name: moduledepname
  params:{
    ResourceLocation:'uksouth'
    webSiteName:'n1site'
  }
  dependsOn: completearrayStas
  scope: resourceGroup(r) //StorageAccount.bicep deploye in RG01 Resource group.
  
}
output module string = stgModule.name

