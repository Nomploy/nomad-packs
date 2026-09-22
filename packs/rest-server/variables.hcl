variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "rest-server"
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
  description = "The restic REST server image. Pin a tag in production."
  type        = string
  default     = "restic/rest-server:latest"
}

variable "port" {
  description = "Host port for the REST API (restic repository endpoint)."
  type        = number
  default     = 8000
}

variable "data_volume" {
  description = "Named volume for restic repositories and the .htpasswd file (/data)."
  type        = string
  default     = "rest_server_data"
}

variable "disable_auth" {
  description = "Disable HTTP basic auth (no .htpasswd needed). Fine on a trusted internal network; keep it false and create users for anything reachable."
  type        = bool
  default     = true
}

variable "append_only" {
  description = "Run append-only: clients can create and read snapshots but cannot delete them (ransomware-resistant). Prune from the server side instead."
  type        = bool
  default     = true
}

variable "extra_options" {
  description = "Extra flags appended to the server OPTIONS (e.g. \"--private-repos\", \"--prometheus\")."
  type        = string
  default     = ""
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
