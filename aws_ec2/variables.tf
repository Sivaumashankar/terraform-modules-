# String → single value

# {} map → multiple values 
# String (single value)
# default = "t3.micro"


# ✔ Used when only one value is needed
# ✔ instance_type, region, key_name etc.

# 2️⃣ Map / Object ({})
# default = {
#   ami = "ami-09c813fb71547fc4f"
# }


# ✔ Used when multiple key–value pairs are needed
# ✔ example: env-wise configs

# Example:

# variable "ami" {
#   default = {
#     dev  = "ami-aaa"
#     prod = "ami-bbb"
#   }
# } 
variable "ami" {
    default = "ami-09c813fb71547fc4f"
  
}

variable "instance_type" {
    default = "t3.micro"
    validation { #variables conditionn terraform select values tearrform
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type) 
    error_message = "Valid values for instance type are: t3.small t3.medium t3.micro "
   
}
}
variable "sg_id" {
  
}
#optional illa isthe tag adhe default evakunda above sg ichinatu isthe mandatory
variable "tags" {
    default = {}
  
}