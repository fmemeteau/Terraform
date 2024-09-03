variable "host" {
    description = "Docker Host IP"
    default = "X.X.X.X"
}

variable "container_name" {
    description = "Container Name"
    type = string
    default = "pdf"
}

variable "image_name" {
    description = "Docker Image Name"
    type = string
    default = "frooodle/s-pdf"
}