resource "aws_security_group" "sourcefuse_sg" {
  name        = "sourcefuse_sg"
  description = "Allow inbound traffic on port 80"
  vpc_id      = aws_vpc.sourcefuse_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Insert your Ip here.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
