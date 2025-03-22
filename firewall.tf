# Creates a firewall rule to allow SSH access on port 2020 from any IP address.
resource "openstack_fw_rule_v2" "ssh_access" {
    name                   = "ssh_access"
    protocol               = "tcp"
    action                 = var.ssh_access
    destination_ip_address = openstack_compute_instance_v2.admin.network.0.fixed_ip_v4
    destination_port       = "2020"
    source_ip_address      = "0.0.0.0/0"
}

# Creates a firewall rule to allow HTTP access on port 80 from any IP address.
resource "openstack_fw_rule_v2" "http_access" {
    name                   = "http_access"
    protocol               = "tcp"
    action                 = "allow"
    destination_ip_address = openstack_lb_loadbalancer_v2.loadBalancer.vip_address
    destination_port       = "80"
    source_ip_address      = "0.0.0.0/0"
}

# Creates a firewall rule to allow internal access for any protocol from any IP address.
resource "openstack_fw_rule_v2" "internal_access" {
    name                   = "internal_access"
    protocol               = "any"
    action                 = "allow"
    source_ip_address      = "0.0.0.0/0"
}

# Creates a firewall policy for ingress traffic.
resource "openstack_fw_policy_v2" "ingress_policy" {
    name  = "ingress_policy"
    rules = [
        openstack_fw_rule_v2.ssh_access.id,
        openstack_fw_rule_v2.http_access.id,
    ]
}

# Creates a firewall policy for egress traffic.
resource "openstack_fw_policy_v2" "egress_policy" {
    name  = "egress_policy"
    rules = [openstack_fw_rule_v2.internal_access.id]
}

# Creates a firewall group and associates it with the ingress and egress firewall policies.
resource "openstack_fw_group_v2" "firewall_group" {
    name = "my_firewall_group"

    ingress_firewall_policy_id = openstack_fw_policy_v2.ingress_policy.id
    egress_firewall_policy_id  = openstack_fw_policy_v2.egress_policy.id
    
    ports      = [openstack_networking_port_v2.router_port.id]

    depends_on = [openstack_networking_router_v2.router]
}