provider "vsphere" {
  vsphere_server = var.vsphere_server
  user = var.vsphere_user
  password = var.vsphere_password
  allow_unverified_ssl = true
}

# --- VARIABLE-DECLARATION

data "vsphere_datacenter" "dc" {
  name = "dc-home"
}

data "vsphere_compute_cluster" "cluster" {
  name = "cluster-home"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name = "rp-home"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name = "openshift_storage"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name = "dpg-home-prod"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# --- Create VM --- #
resource "vsphere_virtual_machine" "tsm-server" {
  name = var.vm_name
  guest_id = var.guest_id_tag
  resource_pool_id = data.vsphere_resource_pool.pool.id
  firmware = "bios"
  datastore_id = data.vsphere_datastore.datastore.id
  num_cpus = 2
  memory = 4096
  wait_for_guest_ip_timeout = 10
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
  disk {
    label = "rootvolume"
    size  = "100"
    thin_provisioned  = "true"
    unit_number = 0
  }
  disk {
    label = "tsmdb01"
    size  = "50"
    thin_provisioned  = "true"
    unit_number = 1
  }
  disk {
    label = "tsmdb02"
    size  = "50"
    thin_provisioned  = "true"
    unit_number = 2
  }
  disk {
    label = "tsmdb03"
    size  = "50"
    thin_provisioned  = "true"
    unit_number = 3
  }
  disk {
    label = "tsmdb04"
    size  = "50"
    thin_provisioned  = "true"
    unit_number = 4
  }
  disk {
    label = "tsmdisk01"
    size  = "500"
    thin_provisioned  = "true"
    unit_number = 5
  }
  disk {
    label = "tsmdisk02"
    size  = "500"
    thin_provisioned  = "true"
    unit_number = 6
  }
  disk {
    label = "tsmdisk03"
    size  = "500"
    thin_provisioned  = "true"
    unit_number = 7
  }
  disk {
    label = "tsmdisk04"
    size  = "500"
    thin_provisioned  = "true"
    unit_number = 8
  }
  disk {
    label = "tsmdisk05"
    size  = "500"
    thin_provisioned  = "true"
    unit_number = 9
  }
  disk {
    label = "tsmactlog"
    size  = "48"
    thin_provisioned  = "true"
    unit_number = 10
  }
  disk {
    label = "tsmarch"
    size  = "192"
    thin_provisioned  = "true"
    unit_number = 11
  }
}
output "vm-hostname" {
  value       = "pxe-installed.home.local"
  description = "The access to the deployed VM-instance."
}
output "user" {
  value       = "root"
}
output "pass" {
  value       = "Test1234"
}
