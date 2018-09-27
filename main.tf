//--------------------------------------------------------------------
// Variables

variable "service_name" {}
variable "service_version" {}
variable "docker_cmd" {}

data "vault_generic_secret" "registry" {
  path = "secret/credentials/docker"
}

//--------------------------------------------------------------------
// Modules

resource "null_resource" "docker_installer" {
	provisioner "local-exec" {
    command = "bash ${path.module}/templates/docker_installer.sh"
  }
}


module "chef_docker" {
  source  = "app.terraform.io/Darnold-WalMart_Demo/chef-docker/packer"
  version = "2.0.1"

  chef_env = "_default"
  docker_cmd = "${var.docker_cmd}"
  docker_password = "${data.vault_generic_secret.registry.data["password"]}"
  docker_registry = "${data.vault_generic_secret.registry.data["host"]}"
  docker_repo = "${data.vault_generic_secret.registry.data["repo"]}"
  docker_username = "${data.vault_generic_secret.registry.data["user"]}"
  service_name = "${var.service_name}"
  service_version = "${var.service_version}"
  vault_chef_credentials_path = "secret/credentials/chef"
  source_image = "ubuntu"
}

	
output "service_version" {
  value = "${var.service_version}"
}
	
output "service_name" {
  value = "${var.service_name}"
}

	
