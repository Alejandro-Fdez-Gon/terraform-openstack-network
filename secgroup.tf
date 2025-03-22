# Creation of a Security Group called open.
resource "openstack_networking_secgroup_v2" "my_security_group" {
    name = "open"
    description = "Security Group to allow all traffic"
    delete_default_rules = true
}

# Rule to allow ingress and egress TCP traffic from any IP.
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_ingress_tcp" {
    direction = "ingress"
    ethertype = "IPv4"
    protocol = "tcp"
    remote_ip_prefix = "0.0.0.0/0"
    security_group_id = openstack_networking_secgroup_v2.my_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rule_egress_tcp" {
    direction = "egress"
    ethertype = "IPv4"
    protocol = "tcp"
    remote_ip_prefix = "0.0.0.0/0"
    security_group_id = openstack_networking_secgroup_v2.my_security_group.id
}

# Rule to allow ingress and egress UDP traffic from any IP.
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_ingress_udp" {
    direction = "ingress"
    ethertype = "IPv4"
    protocol = "udp"
    remote_ip_prefix = "0.0.0.0/0"
    security_group_id = openstack_networking_secgroup_v2.my_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rule_egress_udp" {
    direction = "egress"
    ethertype = "IPv4"
    protocol = "udp"
    remote_ip_prefix = "0.0.0.0/0"
    security_group_id = openstack_networking_secgroup_v2.my_security_group.id
}

# Rule to allow ingress and egress ICMP traffic from any IP (only for development).
# resource "openstack_networking_secgroup_rule_v2" "security_group_rule_ingress_icmp" {
#     direction = "ingress"
#     ethertype = "IPv4"
#     protocol = "icmp"
#     remote_ip_prefix = "0.0.0.0/0"
#     security_group_id = openstack_networking_secgroup_v2.my_security_group.id
# }

# resource "openstack_networking_secgroup_rule_v2" "security_group_rule_egress_icmp" {
#     direction = "egress"
#     ethertype = "IPv4"
#     protocol = "icmp"
#     remote_ip_prefix = "0.0.0.0/0"
#     security_group_id = openstack_networking_secgroup_v2.my_security_group.id
# }