#Create App Service Plan
resource "azurerm_app_service_plan" "vulnerablewebapp_serviceplan" {
  name                = "${var.victim_company}-app"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

#Create App Service
resource "azurerm_app_service" "vulnerablewebapp_appservice" {
  name                = "${var.victim_company}-app-service"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name
  app_service_plan_id = azurerm_app_service_plan.vulnerablewebapp_serviceplan.id
 

  site_config {
    always_on                 = "true"
    dotnet_framework_version = "v4.0"
    python_version           = "3.4"
      }
}

resource "azurerm_app_service_source_control" "example" {
  app_service_id        = azurerm_app_service.vulnerablewebapp_appservice.id
  repo_url              = "https://github.com/metalstormbass/VulnerableWebApp.git"
  is_manual_integration = true
  branch                = "master"
}