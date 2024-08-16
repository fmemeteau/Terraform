# This file contains everythin, from the image to the volume, as it is simpler from a learning point of view

terraform{
    required_providers{
        docker = {
            source = "kreuzwerker/docker"
            version = "3.0.2"
        }
    }
}

provider "docker" {}

resource "docker_volume" "data"{
    name = "vol_db"
}

resource "docker_image" "postgresql" {
    name = "postgres:16.2"
    keep_locally = "false"
}

resource "docker_container" "data" {
    image = docker_image.postgresql.image_id
    name = var.container_name
    hostname = "data-postgre"
    rm = "false"
    env = ["POSTGRES_USER=user-db-test", "POSTGRES_PASSWORD=sdfghjk", "POSTGRES_DB=db-test", "PGDATA=/var/lib/postgresql/data/db-test"]
    
    volumes {
        volume_name = "vol_db"
        container_path = "/var/lib/postgresql/data/db-test"
    } 

    ports {
        external = "5432"
        internal = "5432"
        protocol = "tcp"
    }
}