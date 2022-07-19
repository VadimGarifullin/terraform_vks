terraform {
    required_providers {
        vkcs = {
            source = "vk-cs/vkcs"
        }
        openstack = {
            source  = "terraform-provider-openstack/openstack"
        }
        null = {
            source = "terraform-provider-null/null"
        }
        template = {
            source = "terraform-provider-template/template"
        }
    }
}




provider "vkcs" {
    # Your user account.
    username = "${var.username}"
    # The password of the account
    password = "${var.password}"
    # The tenant token can be taken from the project Settings tab - > API keys.
    # Project ID will be our token.
    project_id = "${var.project_id}"
    # Region name
    region = "RegionOne"
}

provider "openstack" {
    # Your user account.
    user_name = "${var.username}"
    # The password of the account
    password = "${var.password}"
    # The tenant token can be taken from the project Settings tab - > API keys.
    # Project ID will be our token.
    tenant_id = "${var.project_id}"
    # The indicator of the location of users.
 #   user_domain_id = "users"
    # API endpoint
    # Terraform will use this address to access the VK Cloud Solutions api.
    auth_url = "https://infra.mail.ru:35357/v3/"
    # use octavia to manage load balancers
    use_octavia = true 
    # Region name
    region = "RegionOne"
}
