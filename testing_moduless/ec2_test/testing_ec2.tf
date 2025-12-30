module "main" {
  source = "../aws_ec2"
  sg_id = "sg-0a983d8fdd4581edb"
}
output "public_ip" {
    value = module.main.public_ip
  
}