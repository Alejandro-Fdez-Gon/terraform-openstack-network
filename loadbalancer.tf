# Creation of a Load Balancer based on the lb_name variable.
resource "openstack_lb_loadbalancer_v2" "loadBalancer" {
    name          = var.lb_name
    vip_subnet_id = openstack_networking_subnet_v2.subnets[0].id
    
    depends_on    = [openstack_networking_router_v2.router]
}

# Creates a listener for the load balancer based on the lb_name variable.
resource "openstack_lb_listener_v2" "listener_lb" {
    name            = "listener_${var.lb_name}"
    protocol        = "TCP"
    protocol_port   = 80
    loadbalancer_id = openstack_lb_loadbalancer_v2.loadBalancer.id
}

# Creates a pool for the load balancer that will manage the members, based on the lb_name variable.
resource "openstack_lb_pool_v2" "pool_lb" {
    name        = "pool_${var.lb_name}"
    protocol    = "TCP"
    lb_method   = "ROUND_ROBIN"
    listener_id = openstack_lb_listener_v2.listener_lb.id
}

# Creates members for the load balancer pool, based on the num_servers variable.
resource "openstack_lb_member_v2" "members_lb" {
    count         = var.num_servers
    address       = openstack_compute_instance_v2.servers[count.index].network.0.fixed_ip_v4
    protocol_port = 80
    pool_id       = openstack_lb_pool_v2.pool_lb.id
    subnet_id     = openstack_networking_subnet_v2.subnets[0].id
}