resource "aws_security_group" "main" {
  name = var.sg_name
  vpc_id = var.vpc_id
  description = var.project_name
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge(
    var.common_tags,
    var.sg_tags,
    {
        Name = local.sg_final_name
    }
  )
}

