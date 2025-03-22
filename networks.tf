# Create multiple networks dynamically based on the net_names variable.
resource "openstack_networking_network_v2" "nets" {
    count = length(var.net_names)
    name  = var.net_names[count.index]
}

# Create multiple subnets dynamically based on the subnet_names variable.
resource "openstack_networking_subnet_v2" "subnets" {
    count      = length(var.subnet_names)
    name       = var.subnet_names[count.index]
    network_id = openstack_networking_network_v2.nets[count.index].id
    cidr       = var.cidr_list[count.index]
    ip_version = 4

    dns_nameservers = count.index == 0 ? ["8.8.8.8"] : []
    gateway_ip      = count.index == 0 ? var.gateway : null

    allocation_pool {
        start = var.pool_start_list[count.index]
        end = var.pool_end_list[count.index]
    }
}

# Create a router, based on the router_name variable, to connect the internal networks to the external network.
resource "openstack_networking_router_v2" "router" {
    name                = var.router_name
    external_network_id = data.openstack_networking_network_v2.ext-network.id

    depends_on = [openstack_networking_subnet_v2.subnets]
}

resource "openstack_networking_port_v2" "router_port" {
    network_id = openstack_networking_network_v2.nets[0].id
    fixed_ip {
        subnet_id  = openstack_networking_subnet_v2.subnets[0].id
        ip_address = var.gateway
    }
}

# Add an interface to the router.
resource "openstack_networking_router_interface_v2" "net1" {
    router_id = openstack_networking_router_v2.router.id
    port_id = openstack_networking_port_v2.router_port.id
}