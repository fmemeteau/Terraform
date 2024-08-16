output "container_id" {
    description = "ID du conteneur"
    value = docker_container.data.id
}

output "image_id" {
    description = "ID de l'image du conteneur"
    value = docker_image.postgresql.id
}