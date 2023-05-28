output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnet_ids" {
  value = [aws_subnet.sourcefuse_public_subnet_1.id, aws_subnet.sourcefuse_public_subnet_2.id]
}
