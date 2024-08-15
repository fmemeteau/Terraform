terraform{
	required_providers{ 
		docker = {		# source définit hostname, namespace et fournisseur optionnels
			source = "kreuzwerker/docker" 	# = registry.terraform.io/kreuzwerker/docker
			version = "~> 3.0.2"

		}
	}
}


provider "docker" {}

resource "docker_volume" "shared_volume" {
	name = "vol_tuto_nginx"
}

resource "docker_image" "nginx" {
	name = "nginx"
	keep_locally = "false"
}

resource "docker_container" "nginx" {
	image = docker_image.nginx.image_id
	name = "tutorial_nginx"
	rm = "true"

	ports {
		internal = 80
		external = 8080
	}
}
