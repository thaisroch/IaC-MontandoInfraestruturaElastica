terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

# Região utilizada #
provider "aws" {
  region  = var.regiao_aws
}

# Recurso do template de criação #
resource "aws_launch_template" "maquina" {
  image_id      = "ami-03f65b8614a860c29"  #ami-ubuntu-20.04 - (64-bit (x86))
  instance_type        = var.instancia
  key_name             = var.chave
  security_group_names = [ var.security_grupo ]
  # chamando o script
  user_data = filebase64(ansible.sh)
}

# Chave SSH #
resource "aws_key_pair" "chaveSSH" {
    key_name   =   var.chave
    public_key = file("${var.chave}.pub")
}

# Recuso de AutoScaling #
resource "aws_autoscaling_group" "grupo" {
  availability_zones = ["${var.regiao_aws}a, ${var.regiao_aws}b"]
  name               = var.nomeGrupoScaling
  max_size           = var.maximoScaling
  min_size           = var.minimoScaling
  launch_template {
    id      = aws_launch_template.maquina.id
    version = "$Latest"
  }
}
# Subnet A do loadbalance #
resource "aws_default_subnet" "subnetA" {
  availability_zone = "${var.regiao_aws}a"
}
# Subnet B do loadbalance
resource "aws_default_subnet" "subntB" {
  availability_zone = "${var.regiao_aws}b"  
}

# Saída de IP publico quando roda o terrarform #
output "IP_publico" {
  value = aws_launch_template.maquina 
}