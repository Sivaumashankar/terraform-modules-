resource "aws_vpc_peering_connection" "default" {
#   peer_owner_id = 
  #no need same account lo peering iethe vere aws account perring use
  count = var.is_peering_required ? 1 : 0
  
  peer_vpc_id   = local.default_vpc
  vpc_id        = aws_vpc.main.id
  auto_accept   = true
# Same AWS account + same region
# auto_accept = true works
# Peering auto-approved diff account manual accept or terrafoem accpet resource use
  tags = merge(
    var.commontags, var.vpc_peering_tags,

    {
        Name = "${local.resource_name}-default"
    }
  )
}
#peer attch to routes
#public
resource "aws_route" "public_peer" {
    count = var.is_peering_required ? 1: 0

    route_table_id = aws_route_table.public_route_tabel.id
    destination_cidr_block = local.default_cidr
vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
    
  
}
#private
resource "aws_route" "private_peer" {
    count = var.is_peering_required ? 1:0
    route_table_id = aws_route_table.private_route_tabel.id
        destination_cidr_block = local.default_cidr

    vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
  
}
#db
resource "aws_route" "db_peer" {
    count = var.is_peering_required ? 1:0
    route_table_id = aws_route_table.db_route_tabel.id
        destination_cidr_block = local.default_cidr

    vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}

#default nuchi vpc ki peering
resource "aws_route" "default_peer" {
        count = var.is_peering_required ? 1:0
        route_table_id = data.aws_route_table.main.id
        destination_cidr_block = var.vpc_cidr
        vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id

  
}

# terraform destroy -target=aws_vpc_peering_connection.default
# terraform destroy -target=aws_route.public_peer
# terraform destroy -target=aws_route.private_peer
#module level above vi
#kindhavi module use chesi dl chalei ante process
#terraform state list

# terraform destroy -target=module.vpc.aws_route.public_peer
# terraform destroy -target=module.vpc.aws_route.private_peer
# terraform destroy -target=module.vpc.aws_vpc_peering_connection.default



