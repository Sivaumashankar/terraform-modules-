resource "aws_ssm_parameter" "foo" {
  name  = "/${var.project_name}/${var.environment}/sg_id"
  type  = "String"
  value = module.main.sg_id  #moduleorresuource resourcename and ouptut name # resource use chesthe same like ouput value 
}
#module use chesthe same like module ouput value laga

# Direct resource use chesthe (no module)
# resource "aws_security_group" "mysql" {
#   ...
# }

# Then SSM parameter lo:
# resource "aws_ssm_parameter" "mysql_sg_id" {
#   name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
#   type  = "String"
#   value = aws_security_group.mysql.id
# }