variable "img_source" {
  description = "ISO utilisée"
  default     = "/mnt/vms/isos/pop-os_22.04_amd64_nvidia_33.iso"
}

variable "img_format" {
  description = "Format du disque utilisé"
  default     = "qcow2"
  type        = string
}

variable "mem_size" {
  description = "RAM allouée à la VM"
  default     = "2048"
  type        = string
}

variable "vcpu_cores" {
  description = "Nombre de vcpus alloués"
  default     = "2"
  type        = number
}

variable "disk_size" {
  description = "Taille du disque"
  default     = "21474836480"
  type        = number
}