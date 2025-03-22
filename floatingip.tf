# Creation of the floating IPs for external access.
resource "openstack_networking_floatingip_v2" "floatip_admin" {
    pool = data.openstack_networking_network_v2.ext-network.name
}

resource "openstack_networking_floatingip_v2" "floatip_lb" {
    pool = data.openstack_networking_network_v2.ext-network.name
}

# Association of the floating IPs for the devices.
resource "openstack_networking_floatingip_associate_v2" "floatip_admin" {
    floating_ip = openstack_networking_floatingip_v2.floatip_admin.address
    port_id     = data.openstack_networking_port_v2.port_admin.id
}

resource "openstack_networking_floatingip_associate_v2" "floatip_lb" {
    floating_ip = openstack_networking_floatingip_v2.floatip_lb.address
    port_id     = openstack_lb_loadbalancer_v2.loadBalancer.vip_port_id
}