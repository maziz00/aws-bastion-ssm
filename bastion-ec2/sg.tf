resource "aws_security_group" "bastion_ncde_sg" {
  name        = "bastion-ncde-sg"
  description = "Security group for Bastion NCDE"
  vpc_id      = "vpc-0b48425912a33fe9a"

#   No inbound rules required for SSM access
#   ingress {
#     from_port   = -1
#     to_port     = -1
#     protocol    = "tcp"
#     cidr_blocks = ["5.195.222.2/32"]
#   }

  # Outbound: Allow HTTPS to connect to SSM
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}