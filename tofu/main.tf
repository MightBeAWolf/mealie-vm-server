terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_api_uri
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = var.pm_tls_insecure
}

resource "proxmox_vm_qemu" "guest" {
  name  = "${var.name}"
  clone = "${var.from_template}"
  desc = "${var.desc}"
  target_node="${var.target_node}"
  tags="${var.tags}"
  qemu_os = "l26"
  agent = 1
  pool = "${var.pool}"

  onboot = "${var.start_vm_on_boot}"

  vmid = "${var.id}"
  sockets = var.compute.sockets
  cores = var.compute.cores
  memory = var.compute.memory

  disks {
    ide{
      ide0{
        cloudinit{
          storage = var.disk.storage
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = var.disk.size
          storage = var.disk.storage
          backup = var.disk.backup
        }
      }
    }
  }

  network {
    bridge = var.network.bridge
    model = var.network.model
    tag = var.network.tag
    firewall = var.network.firewall
  }

  # Specify cloud init settings
  os_type    = "cloud-init"
  ipconfig0  = "ip=${var.ipv4}${var.cidr},gw=${var.gateway}"
  nameserver = "${var.gateway}"
  ciuser = var.node_user
  cipassword = var.node_user_password
  sshkeys = var.ssh_pub_key

  provisioner "remote-exec" {
    inline = [ "echo 'Wait until SSH is ready'" ]
    connection {
      type = "ssh"
      user = var.node_user
      host = "${var.ipv4}"
    }
  }

   provisioner "local-exec" {
     command = "ansible-playbook ../ansible/playbooks/main.yml"
     working_dir = "../ansible"
   }
}
