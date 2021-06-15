variable "resourcename" {
  description = "this is a resourcegroup"
}
variable "location" {
}
variable "tags" {
  type = map
}

variable "vm_count" {
  type = bool
}


variable "networkrule" {
}
variable "enviornment" {

}

variable "address_space" {
type= list(string)  
}

variable "tag2" {

}

variable "subnet_space" {
  type= list(string)  
}

variable "subnet_count" {
  
}