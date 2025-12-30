variable "project" {
    
  
}
variable "environment" {
  
}
variable "vpc_cidr" {
    
  
}
variable "enable_dns_hostnames" {
    default = true
  
}

variable "commontags" {
    type = map(string)
   
     }

variable "vpc_tags" {
    default = {}
  
}
variable "aws_internet_gateway_tag" {
    default = {}
  
}
variable "public_subnet_tag" {
    default = {}
  
}
variable "public_subnet_cidrs"{
  type = list
  validation {
    condition     = length(var.public_subnet_cidrs)==2
    error_message = "Please provide 2 valid public subnet CIDR"
  }
  
}
variable "private_subnet_cidrs" {
    type = list(string)
    validation {
      condition = length(var.private_subnet_cidrs)==2
      error_message = "please provide 2 private subnet cidrs"
    }
  
}
variable "private_subnet_tags" {
    default = {}
  
}


variable "db_subnet_cidrs" {
    type = list(string)
    validation {
      condition = length(var.db_subnet_cidrs)==2
      error_message = "please provide 2 db subnets cidrs"
    }
  
}
variable "db_subnet_tags" {
    default = {}
  
}

variable "public_route_tabel_tags" {
    default = {}
  
}
variable "private_route_tabel_tags" {
    default = {}
  
}
variable "db_route_tabel_tags" {
    default = {}
  
}

variable "nat_gateway_tags" {
  default = {}
}

#peering variables
variable "is_peering_required" {
    default = false
}

variable "vpc_peering_tags" {
    default = {}
}
#  terraform state list | Select-String peering or grep peering
#  terraform state show module.vpc.aws_vpc_peering_connection.default