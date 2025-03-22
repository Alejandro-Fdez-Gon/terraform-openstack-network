# Create multiple virtual machine instances dynamically based on the num_servers variable.
resource "openstack_compute_instance_v2" "servers" {
    count           = var.num_servers
    name            = "S${count.index + 1}"
    image_name      = data.openstack_images_image_v2.jammy.name
    flavor_name     = data.openstack_compute_flavor_v2.m1-smaller.name
    key_pair        = openstack_compute_keypair_v2.key_serv[count.index].name
    security_groups = [openstack_networking_secgroup_v2.my_security_group.name]

    network {
        name = openstack_networking_network_v2.nets[0].name
    }
    network {
        name = openstack_networking_network_v2.nets[1].name
    }

    user_data  = file("cloud-init-web")
    depends_on = [openstack_networking_router_v2.router]
}

# Creation of virtual machine instance for the admin server based on the admin_name variable.
resource "openstack_compute_instance_v2" "admin" {
    name            = var.admin_name
    image_name      = data.openstack_images_image_v2.jammy.name
    flavor_name     = data.openstack_compute_flavor_v2.m1-smaller.name
    key_pair        = openstack_compute_keypair_v2.key_admin.name
    security_groups = [openstack_networking_secgroup_v2.my_security_group.name]

    network {
        name = openstack_networking_network_v2.nets[0].name
    }
    network {
        name = openstack_networking_network_v2.nets[1].name
    }

    user_data  = file("cloud-init-admin")
    depends_on = [openstack_networking_router_v2.router]
}

# Creation of virtual machine instance for the BBDD based on the bbdd_name variable.
resource "openstack_compute_instance_v2" "bbdd" {
    name            = var.bbdd_name
    image_name      = data.openstack_images_image_v2.bbdd.name
    flavor_name     = data.openstack_compute_flavor_v2.m1-smaller.name
    key_pair        = openstack_compute_keypair_v2.key_bbdd.name
    security_groups = [openstack_networking_secgroup_v2.my_security_group.name]

    network {
        name = openstack_networking_network_v2.nets[1].name
    }

    depends_on = [openstack_networking_router_v2.router]
}