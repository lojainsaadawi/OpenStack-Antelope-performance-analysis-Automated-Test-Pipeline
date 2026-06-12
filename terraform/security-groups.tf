# Security group allowing all traffic needed for performance testing
resource "openstack_networking_secgroup_v2" "perf_sg" {
  name        = "${var.network_prefix}-perf-sg"
  description = "Security group for performance testing VMs"
}

# Allow all ICMP (ping)
resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.perf_sg.id
}

# Allow all TCP (for iperf3 and SSH)
resource "openstack_networking_secgroup_rule_v2" "tcp_all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.perf_sg.id
}

# Allow all UDP (for iperf3 UDP)
resource "openstack_networking_secgroup_rule_v2" "udp_all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.perf_sg.id
}

# Allow all egress
resource "openstack_networking_secgroup_rule_v2" "egress_all" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.perf_sg.id
}
