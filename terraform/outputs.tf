# Output all VM private IPs (useful for debugging)
output "vm_ips" {
  value = {
    for name, vm in openstack_compute_instance_v2.perf_vm :
    name => vm.network[0].fixed_ip_v4
  }
}

output "floating_ips" {
  value = {
    for name, fip in openstack_networking_floatingip_v2.fip :
    name => fip.address
  }
}

# Generate Ansible inventory with scenario groups
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible-inventory.tpl", {
    vm_ips = {
      for name, vm in openstack_compute_instance_v2.perf_vm :
      name => {
        ip    = openstack_networking_floatingip_v2.fip[name].address
        group = (
          can(regex("sc1$", name)) ? "scenario1" : (
            can(regex("sc2$", name)) ? "scenario2" : (
              can(regex("sc3$", name)) ? "scenario3" : "scenario4"
            )
          )
        )
      }
    }
  })
  filename = "${path.module}/../hosts.ini"
}
