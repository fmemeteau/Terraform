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
	name = "vol_sql_web"
}

resource "docker_network" "db-network" {
	name = "web-net"
}

resource "docker_image" "wordpress" {
	name = "wordpress:php8.3-apache"
	keep_locally = "true"
}

resource "docker_image" "sql" {
	name = "mysql:8.0.39-bookworm"
	keep_locally = "true"
}

resource "docker_container" "wordpress" {
	image = docker_image.wordpress.image_id
	name = "web"
	networks_advanced {
		name = docker_network.db-network.id
	}
	rm = "true"

	env = ["WORDPRESS_DB_HOST=web-db:3306", "WORDPRESS_DB_USER=var.db-user", "WORDPRESS_DB_NAME=web-db", "WORDPRESS_DB_PASSWORD=var.db-user-pw"]

	ports {
		internal = 80
		external = 80
	}
}


resource "docker_container" "sql" {
	image = docker_image.sql.image_id
	name = "web-db"
	restart = "always"
	env = ["MYSQL_USER=var.db-user", "MYSQL_PASSWORD=var.db-user-pw", "MYSQL_DATABASE=web-db", "MYSQL_ROOT_PASSWORD=var.db-root-pw"]

	networks_advanced {
		name = docker_network.db-network.id
	}

	volumes {
		volume_name = docker_volume.shared_volume.name
		container_path = "/var/lib/data/web-db/"
	}

}