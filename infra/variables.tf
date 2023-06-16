## VARIAVEIS ##

variable "regiao_aws" {
    type = string
}

variable "chave" {
    type = string
}

variable "instancia" {
    type = string
}

variable "security_grupo" {
    type = string
}

# Grupo de autoScaling
variable "maximoScaling" {
    type = number
}

variable "minimoScaling" {
    type = number
}

variable "nomeGrupoScaling" {
    type = string
}