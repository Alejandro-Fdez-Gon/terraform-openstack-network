variable "num_servers" {
    description = "Number of instances to deploy"
    type        = number
    default     = 3
}

variable "admin_name" {
    description = "Admin instance name"
    type        = string
    default     = "ADMIN"
}

variable "bbdd_name" {
    description = "Database name"
    type        = string
    default     = "BBDD"
}

variable "net_names" {
    description = "List of names for the networks"
    type        = list(string)
    default     = ["net1", "net2"]
}

variable "subnet_names" {
    description = "List of names for the subnets"
    type        = list(string)
    default     = ["subnet1", "subnet2"]
}

variable "cidr_list" {
    description = "List of CIDR blocks for the subnets"
    type        = list(string)
    default     = ["10.1.2.0/24", "10.1.3.0/24"]
}

variable "gateway" {
    description = "Gateway for subnet1"
    type        = string
    default     = "10.1.2.1"
}

variable "pool_start_list" {
    description = "List of the start IP addresses for the IP pool of the subnets"
    type        = list(string)
    default     = ["10.1.2.2", "10.1.3.2"]
}

variable "pool_end_list" {
    description = "List of the end IP addresses for the IP pool of the subnets"
    type        = list(string)
    default     = ["10.1.2.100", "10.1.3.100"]
}

variable "router_name" {
    description = "Router name"
    type        = string
    default     = "r0"
}

variable "lb_name" {
    description = "Load balancer name"
    type        = string
    default     = "LB"
}

variable "ssh_access" {
    description = "Action of the ssh access firewall rule"
    type        = string
    default     = "allow"
}