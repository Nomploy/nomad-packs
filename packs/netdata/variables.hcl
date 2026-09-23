variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "netdata"
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
  description = "The Netdata container image. Pin a tag in production."
  type        = string
  default     = "netdata/netdata:latest"
}

variable "port" {
  description = "Host port for the Netdata web UI / API. The agent listens on 19999."
  type        = number
  default     = 19999
}

variable "config_volume" {
  description = "Named volume for Netdata configuration (/etc/netdata)."
  type        = string
  default     = "netdata_config"
}

variable "lib_volume" {
  description = "Named volume for Netdata state / metrics database (/var/lib/netdata)."
  type        = string
  default     = "netdata_lib"
}

variable "cache_volume" {
  description = "Named volume for Netdata cache (/var/cache/netdata)."
  type        = string
  default     = "netdata_cache"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Netdata task. It keeps recent metrics in memory; bump for many charts."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
