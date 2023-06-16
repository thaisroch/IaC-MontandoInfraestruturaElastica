module "ambienteDEV" {
  source           = "../../infra"
  instancia        = "t2.micro"
  regiao_aws       = "us-west-2"
  chave            = "ambienteDEV"
  security_grupo   = "security_grupo_Dev"
  minimoScaling    = 0
  maximoScaling    = 1
  nomeGrupoScaling = "Instance Auto Scaling Developer"
}
output "IP" {
  value = module.ambienteDEV.IP_publico
}