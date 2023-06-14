module "ambienteProd" {
    source         = "../../infra"
    instancia      = "t2.micro"
    regiao_aws     = "us-west-2"
    chave          = "ambienteProducao"
    security_grupo = "security_grupo_Prod"
    instancia_name = "Instancia Produção"
}

output "IP" {
    value = module.ambienteProd.IP_publico
}