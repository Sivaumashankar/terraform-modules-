output "vpc_id" {
    value = aws_vpc.main.id
  
}
output "igw_id" {
    value = aws_internet_gateway.gw.id
  
}
output "public_subnet_id" {
    value = aws_subnet.public[*].id
  
}#
output "private_subnet_id" {
    value = aws_subnet.private_subnet[*].id
  
}
output "db_subnet_id" {
    value = aws_subnet.db_subnet[*].id
  
}
output "eip_id" {
  value = aws_eip.example.id
}
