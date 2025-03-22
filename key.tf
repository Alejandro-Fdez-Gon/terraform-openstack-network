# Creation of SSH key pairs for the servers based on the num_servers variable.
resource "openstack_compute_keypair_v2" "key_serv" {
    count = var.num_servers
    name  = "S${count.index + 1}"
}

# Creation of SSH key pair for the admin server based on the admin_name variable.
resource "openstack_compute_keypair_v2" "key_admin" {
    name  = var.admin_name
}

# Creation of SSH key pair for the BBDD based on the bbdd_name variable.
resource "openstack_compute_keypair_v2" "key_bbdd" {
    name  = var.bbdd_name
}