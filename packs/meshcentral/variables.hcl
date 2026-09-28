variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "meshcentral"
}

variable "namespace" {
  description = "The Nomad namespace to deploy into."
  type        = string
  default     = "default"
}

variable "datacenters" {
  description = "The datacenters to deploy to."
  type        = list(string)
  default     = ["*"]
}

variable "image" {
  description = "The MeshCentral container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/ylianst/meshcentral:latest"
}

variable "port" {
  description = "Host port for the MeshCentral web UI (HTTPS)."
  type        = number
  default     = 4430
}

variable "redir_port" {
  description = "Host port for the HTTP-to-HTTPS redirect."
  type        = number
  default     = 8081
}

variable "hostname" {
  description = "Public hostname/IP of this server (used in agent config). Set to your node's address."
  type        = string
  default     = "localhost"
}

variable "allow_new_accounts" {
  description = "Allow self-registration of new accounts after the first admin (true/false)."
  type        = string
  default     = "false"
}

variable "data_volume" {
  description = "Named volume for MeshCentral config and its embedded database (/opt/meshcentral/meshcentral-data)."
  type        = string
  default     = "meshcentral_data"
}

variable "files_volume" {
  description = "Named volume for user files (/opt/meshcentral/meshcentral-files)."
  type        = string
  default     = "meshcentral_files"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
