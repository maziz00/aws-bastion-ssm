resource "aws_instance" "ssm_instance" {
  ami                  = "ami-0aafc8599e4a5c6c3"  # Amazon Linux AMI
  instance_type        = "t3.medium"
  key_name             = "bastion-prod"
  subnet_id            = "subnet-prod"
  iam_instance_profile = "EC2-SSM-Role"

  vpc_security_group_ids = [aws_security_group.bastion_ncde_sg.id]

  tags = {
    Name = "bastion-prod"
  }
}