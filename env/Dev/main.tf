module "ambienteDEV" {
  source         = "../../infra"
  instancia      = "t2.micro"
  regiao_aws     = "us-west-2"
  chave          = "ambienteDEV"
  security_grupo = "security_grupo_Dev"
  instancia_name = "Instancia Desenvolvimento" 
}

output "IP" {
  value = module.ambienteDEV.IP_publico
}