variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "termix"
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
  description = "The Termix container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/lukegus/termix:latest"
}

variable "guacd_image" {
  description = "The guacd (Apache Guacamole proxy daemon) image used for RDP/VNC sessions."
  type        = string
  default     = "guacamole/guacd:1.6.0"
}

variable "port" {
  description = "Host port for the Termix web UI."
  type        = number
  default     = 8080
}

variable "guacd_port" {
  description = "Host port for the bundled guacd daemon (loopback only)."
  type        = number
  default     = 4822
}

variable "data_volume" {
  description = "Named volume for Termix data (inventory, settings, session recordings, RDP drive), shared with guacd."
  type        = string
  default     = "termix_data"
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
  description = "Resources for the Termix app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "guacd_resources" {
  description = "Resources for the bundled guacd task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
