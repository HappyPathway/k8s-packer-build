//--------------------------------------------------------------------
// Variables
variable "username" {}
variable "password" {}
variable "service_name" {}
variable "service_version" {}
variable "docker_cmd" {}

variable "registry" {
	default = "https://index.docker.io/v1/"
}
variable "repo" {
  default = "happypathway"
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
  version = "1.2.7"

  chef_env = "_default"
	docker_cmd = "${var.docker_cmd}"
  docker_password = "${var.password}"
  docker_registry = "${var.registry}"
  docker_repo = "${var.repo}"
  docker_username = "${var.username}"
  service_name = "${var.service_name}"
  service_version = "${var.service_version}"
  vault_chef_credentials_path = "secret/credentials/chef"
	source_image = "ubuntu"
}
