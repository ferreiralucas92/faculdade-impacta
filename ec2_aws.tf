# Provider AWS
provider "aws" {
  region     = "us-east-1"  # Insira sua região desejada
}

# Recurso para criar uma instância EC2
resource "aws_instance" "project_iac" {
  ami           = "ami-0c94855ba95c71c99"  # AMI do Amazon Linux 2 (ajuste de acordo com sua região)
  instance_type = "t2.micro"  # Tipo de instância desejada

# Definição das tags
  tags = {
    Name = "Faculdade Impacta"
  }

  # Automatização de instalação do Nginx
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install -y nginx1
              sudo service nginx start
              sudo chkconfig nginx on
              EOF
}

# Regra de Inbound para permitir tráfego HTTP na porta 80
resource "aws_security_group" "instance" {
  name        = "allow_http"
  description = "Permite tráfego HTTP"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}