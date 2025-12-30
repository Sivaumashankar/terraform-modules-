module "main" {
  source = "../sg"
 project_name = var.project_name
    environment = var.environment
    sg_name = "mysql"
    sg_description = "Created for MySQL instances in expense dev"
     vpc_id =data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}