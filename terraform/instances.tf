# Data sources for image, flavor, keypair
data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name
}

data "openstack_compute_keypair_v2" "keypair" {
  name = var.keypair_name
}

# Local map defining each VM: name, availability zone, network ID
locals {
  vm_config = {
    # Scenario 1: Same node (compute1), same network (net1)
    "perf-vm1-sc1" = { az = "nova:compute1", network = openstack_networking_network_v2.net1.id }
    "perf-vm2-sc1" = { az = "nova:compute1", network = openstack_networking_network_v2.net1.id }

    # Scenario 2: Same node (compute1), different networks (net1 & net2)
    "perf-vm1-sc2" = { az = "nova:compute1", network = openstack_networking_network_v2.net1.id }
    "perf-vm2-sc2" = { az = "nova:compute1", network = openstack_networking_network_v2.net2.id }

    # Scenario 3: Different nodes (compute1 & compute2), same network (net1)
    "perf-vm1-sc3" = { az = "nova:compute1", network = openstack_networking_network_v2.net1.id }
    "perf-vm2-sc3" = { az = "nova:compute2", network = openstack_networking_network_v2.net1.id }

    # Scenario 4: Different nodes (compute1 & compute2), different networks (net1 & net2)
    "perf-vm1-sc4" = { az = "nova:compute1", network = openstack_networking_network_v2.net1.id }
    "perf-vm2-sc4" = { az = "nova:compute2", network = openstack_networking_network_v2.net2.id }
  }
}

# Create all VMs
resource "openstack_compute_instance_v2" "perf_vm" {
  for_each = local.vm_config

  name              = each.key
  image_id          = data.openstack_images_image_v2.image.id
  flavor_id         = data.openstack_compute_flavor_v2.flavor.id
  key_pair          = data.openstack_compute_keypair_v2.keypair.name

  availability_zone = each.value.az
  
  security_groups   = [openstack_networking_secgroup_v2.perf_sg.name]

  power_state       = "shutoff"

  network {
    uuid = each.value.network
  }
}
