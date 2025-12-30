resource "aws_instance" "main" {
    ami = var.ami
    # instance_type = var.instance_type
    instance_type = local.instance_type
    vpc_security_group_ids = [ var.sg_id ]
#     String variable → .id vaddu

# Resource reference → .id correct
    tags = {
      
    }
  
} #person who creates modules also gives documentaion 