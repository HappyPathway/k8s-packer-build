variable "service_name" {
    type="string"
}
resource "tfe_variable" "service_name" {
    key = "service_name"
    value = "${var.service_name}"
    category = "terraform"
    workspace_id = "${module.workspace.workspace_id}"
}

variable "service_version" {
    type="string"
}
resource "tfe_variable" "service_version" {
    key = "service_version"
    value = "${var.service_version}"
    category = "terraform"
    workspace_id = "${module.workspace.workspace_id}"
}

variable "docker_cmd" {
    type="string"
}
resource "tfe_variable" "docker_cmd" {
    key = "docker_cmd"
    value = "${var.docker_cmd}"
    category = "terraform"
    workspace_id = "${module.workspace.workspace_id}"
}

