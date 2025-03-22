# Define required providers.
terraform {
required_version = ">= 0.14.0"
    required_providers {
        openstack = {
            source = "terraform-provider-openstack/openstack"
            version = "~> 1.53.0"
        }
    }
}

# Configure the OpenStack Provider.
provider "openstack" {
    user_name = "admin"
    tenant_name = "admin"
    password = "xxxx"
    user_domain_name = "Default"
    project_domain_name = "Default"
    auth_url = "http://controller:5000/v3"
    region = "RegionOne"
}