variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ntopng"
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
  description = "The ntopng container image. Pin a tag in production."
  type        = string
  default     = "ntop/ntopng:latest"
}

variable "port" {
  description = "Host port for the ntopng web UI."
  type        = number
  default     = 3000
}

variable "interface" {
  description = "The host network interface to capture traffic from (e.g. eth0, ens18)."
  type        = string
  default     = "eth0"
}

variable "data_volume" {
  description = "Named volume for ntopng data and its bundled Redis (/var/lib/ntopng)."
  type        = string
  default     = "ntopng_data"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\". Pin to the node whose traffic you want to analyse."
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
    cpu    = 1000
    memory = 1024
  }
}
