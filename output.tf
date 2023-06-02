output "subnets" {
  value = [
    aws_subnet.sourcefuse_public_subnet_1.id,
    aws_subnet.sourcefuse_public_subnet_2.id,
    aws_subnet.sourcefuse_private_subnet.id,
    aws_subnet.sourcefuse_private_subnet2.id
  ]
}
