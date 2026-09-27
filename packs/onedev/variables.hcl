variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "onedev"
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
  description = "The OneDev container image. Pin a tag in production."
  type        = string
  default     = "1dev/server:latest"
}

variable "port" {
  description = "Host port for the OneDev web UI / HTTP git."
  type        = number
  default     = 6610
}

variable "ssh_port" {
  description = "Port for git-over-SSH."
  type        = number
  default     = 6611
}

variable "data_volume" {
  description = "Named volume mounted at /opt/onedev — repositories, the embedded database and config."
  type        = string
  default     = "onedev_data"
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
    cpu    = 1500
    memory = 2048
  }
}
