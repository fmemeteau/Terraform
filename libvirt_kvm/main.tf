terraform {
    required_providers {
        libvirt = {
            source = "dmacvicar/libvirt"
            version = "0.7.6"
        }
    }
}

provider "libvirt" {
    uri = "qemu:///system"
}

resource "libvirt_volume" "base_size" {
    name = "vm_base.{$var.img_format}"
    source = var.img_source
    format = var.img_format
    pool = "VMs"
}

resource "libvirt_volume" "vol_test" {
    name = "vol_test_ubuntu"
    base_volume_id = libvirt_volume.base_size.id
    pool = "VMs"
    size = "21474836480"
}

resource "libvirt_domain" "vm_test" {
    name = "vm_test"
    vcpu = var.vcpu_cores
    memory = var.mem_size
    autostart = "false"

    disk {
        volume_id = libvirt_volume.vol_test.id
    }

    network_interface {
        network_name = "proxyArp"
    }
    
    console {
        type = "pty"
        target_type = "serial"
        target_port = "0"
    }

    graphics {
        type = "spice"
        autoport = "true"
        listen_type = "address"
    }
}