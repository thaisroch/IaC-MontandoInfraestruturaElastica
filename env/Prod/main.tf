module "ambienteProd" {
  source           = "../../infra"
  instancia        = "t2.micro"
  regiao_aws       = "us-west-2"
  chave            = "ambienteProducao"
  security_grupo   = "security_grupo_Prod"
  maximoScaling    = 3
  minimoScaling    = 1
  nomeGrupoScaling = "Production"
}
