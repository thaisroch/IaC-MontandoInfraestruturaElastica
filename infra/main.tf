terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.regiao_aws
}

resource "aws_launch_template" "maquina" {
  image_id      = "ami-03f65b8614a860c29"  #ami-ubuntu-20.04 - (64-bit (x86))
  instance_type = var.instancia
  key_name      = var.chave
  tags = {
    Name        = var.instancia_name
  }
}

resource "aws_key_pair" "chaveSSH" {
    key_name   =   var.chave
    public_key = file("${var.chave}.pub")
  
}

output "IP_publico" {
  value = aws_launch_template.maquina  #trans o ip_public
}