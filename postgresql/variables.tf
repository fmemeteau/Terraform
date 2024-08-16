variable "container_name" {
    description = "Nom du conteneur DB"
    type = string
    default = "db-postgre"
}

variable "db_name" {
    description = "Nom de la base de données"
    type = string
    default = "db-test"
}