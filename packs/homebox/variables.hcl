variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "homebox"
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
  description = "The HomeBox container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/sysadminsmedia/homebox:latest"
}

variable "port" {
  description = "Host port for the HomeBox web UI (HBOX_WEB_PORT)."
  type        = number
  default     = 7745
}

variable "allow_registration" {
  description = "Allow new users to self-register (HBOX_OPTIONS_ALLOW_REGISTRATION)."
  type        = bool
  default     = true
}

variable "data_volume" {
  description = "Named volume for the SQLite database and uploads (/data)."
  type        = string
  default     = "homebox_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
    cpu    = 300
    memory = 128
  }
}
