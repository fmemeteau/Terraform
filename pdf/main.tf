terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
}

resource "docker_volume" "Data" {
    name = "data"
}

resource "docker_volume" "Config" {
    name = "config"
}

resource "docker_volume" "Logs" {
    name = "logs"
}

resource "docker_image" "pdf" {
    name = "${var.image_name}:latest"
    keep_locally = "true"
}

resource "docker_container" "pdf" {
    image = docker_image.pdf.image_id
    name = var.container_name
    
    ports {
        internal = 8080
        external = 8080
    }

    volumes {
        volume_name = docker_volume.Data.name
        container_path = "/usr/share/tessdata"
    }

    volumes {
        volume_name = docker_volume.Config.name
        container_path = "/configs"
    }

    volumes {
        volume_name = docker_volume.Logs.name
        container_path = "/logs"
    }

    env = ["DOCKER_ENABLE_SECURITY=false","INSTALL_BOOK_AND_ADVANCED_HTML_OPS=false","LANGS=en_GB"]
}