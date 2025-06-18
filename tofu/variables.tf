variable "ssh_pub_key" {
  description = "The public ssh key used to access the nodes"
  type        = string
  sensitive   = true
}

variable "node_user" {
  description = "The user created in the nodes"
  type        = string
}

variable "node_user_password" {
  description = "The password for the node user"
  type        = string
  sensitive   = true
}


variable "pm_api_uri" {
  description = "The Proxmox API URI."
  type        = string
}

variable "pm_api_token_id" {
  description = "The Proxmox API token created for a specific user."
  type        = string
}

variable "pm_api_token_secret" {
  description = "The password for the Proxmox API user"
  type        = string
  sensitive   = true
}

variable "pm_tls_insecure" {
  description = "Disable TLS verification for Proxmox API"
  type        = bool
  default     = true
}

variable "from_template" {
  description = "The name of the template to clone from"
  type        = string
  default     = true
}

variable "start_vm_on_boot" {
  description = "Whether to have the VM startup after the PVE node starts."
  type        = bool
  default     = false
}

variable "name" {
  type = string 
}

variable "id" {
  type = number 
}

variable "ipv4" {
  type = string 
}

variable "cidr" {
  type = string 
  default = "/24"
}

variable "gateway" {
  type = string 
}

variable "desc" {
  type = string 
}

variable "target_node" {
  type = string
}

variable "tags" {
  type = string
}

variable "pool" {
  type = string
}

variable "disk" {
  type = object({
    storage = string
    size    = string
    backup  = bool
  })
  default = {
    storage = "local-lvm"
    size    = "20G"
    backup  = true
  }
}

variable "network" {
  type = object({
    bridge = string
    model  = string
    tag = number
    firewall = bool
  })
  default = {
    bridge = "vmbr0"
    model  = "virtio"
    tag    = 0
    firewall = true
  }
}

variable "compute" {
  description = "Resource settings for each VM"
  type = object({
    sockets  = number
    cores   = number
    memory  = number
  })
  default = {
    sockets = 1
    cores   = 1
    memory  = 512
  }
}
