resourcename  = "AzureRMResource"
location      = "East Us"
vm_count      = true
tags          = { enviornment = "demo", owner = "test", purpose = "demo" }
networkrule = [
  {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"  
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "test1234"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    destination_port_range     = "*"   
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
]
tag2 = {resource="virtualmachine",costcentre = "demoyfcourse"}
enviornment = "sandbox"
loc = ["east","us"]
address_space = ["10.0.0.0/16","10.0.0.1/32","10.0.0.1/24"] 
subnet_space=["10.0.2.0/24","10.0.3.0/24"]
subnet_count= true