resource "openstack_networking_floatingip_v2" "fip" {
  for_each = openstack_compute_instance_v2.perf_vm
  pool     = var.external_network
}

resource "openstack_compute_floatingip_associate_v2" "associate" {
  for_each   = openstack_compute_instance_v2.perf_vm
  floating_ip = openstack_networking_floatingip_v2.fip[each.key].address
  instance_id = each.value.id
}
