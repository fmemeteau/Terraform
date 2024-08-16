# Sensibles, le contenu des variables est indiqué dans le fichier "secrets.tfvars"
variable "db-user" {
    description = "DB username"
    type = string
    sensitive = true
}

variable "db-user-pw" {
    description = "DB user password"
    type = string
    sensitive = true
}

variable "db-root-pw" {
    description = "DB root password"
    type = string
    sensitive = true
}
