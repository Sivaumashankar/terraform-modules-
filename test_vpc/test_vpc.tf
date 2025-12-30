module "vpc" {
    source = "../vpc"
    project = "transport"
    environment = "dev"
    vpc_cidr = "10.0.0.0/16" #doubt
    commontags = {
      project="transport"

     }
     public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
     db_subnet_cidrs = ["10.0.11.0/24","10.0.12.0/24"]
     private_subnet_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]
      is_peering_required = true

}
#bash
# terraform destroy -target=module.vpc.aws_route.public_peer[0]
# terraform destroy -target=module.vpc.aws_route.private_peer[0]
# terraform destroy -target=module.vpc.aws_route.db_peer[0]
# terraform destroy -target=module.vpc.aws_route.default_peer[0]
# powershell
# terraform destroy -target="module.vpc.aws_route.public_peer[0] - autoapprove"
# terraform destroy -target="module.vpc.aws_route.private_peer[0]"
# terraform destroy -target="module.vpc.aws_route.db_peer[0]"
# terraform destroy -target="module.vpc.aws_route.default_peer[0]"

