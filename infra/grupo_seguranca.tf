resource "aws_security_group" "grupo_seguranca_geral" {
    name        = var.security_grupo
    description = "grupo dos ambientes"
    ingress {
        cidr_blocks      = ["0.0.0.0/0"] # ipv4
        ipv6_cidr_blocks = ["::/0"] # ipv6
        from_port        = 0
        to_port          = 0     # Todas as portas
        protocol         = "-1" #todos os protocolos
    }
    egress {
        cidr_blocks      = ["0.0.0.0/0"] # ipv4
        ipv6_cidr_blocks = ["::/0"] # ipv6
        from_port        = 0
        to_port          = 0     # Todas as portas
        protocol         = "-1" #todos os protocolos  
    }
    tags = {
      Name = "grupo_seguranca_geral"
    }
}

