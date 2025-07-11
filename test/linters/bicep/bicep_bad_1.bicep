param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'name'
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

resource webApplication 'Microsoft.Web/sites@2023-12-01' = {
  name: 'name'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
  dependsOn: [
    appServicePlan
  ]
}
