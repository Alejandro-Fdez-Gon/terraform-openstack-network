# Data sources to get the existing images information.
data "openstack_images_image_v2" "jammy" {
    name = "jammy-server-cloudimg-amd64-vnx"
}

data "openstack_images_image_v2" "bbdd" {
    name = "bbdd-alejandro-fernandez"
}

# Data sources to get the existing flavours information.
data "openstack_compute_flavor_v2" "m1-smaller" {
    name = "m1.smaller"
}

# Data sources to get the name of the External Network.
data "openstack_networking_network_v2" "ext-network" {
    name = "ExtNet"
}

# Data sources to get the port information for specific devices.
data "openstack_networking_port_v2" "port_admin" {
    device_id  = openstack_compute_instance_v2.admin.id
    network_id = openstack_compute_instance_v2.admin.network.0.uuid
}