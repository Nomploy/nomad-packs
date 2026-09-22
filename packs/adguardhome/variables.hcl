variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "adguardhome"
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
  description = "The AdGuard Home container image. Pin a tag in production."
  type        = string
  default     = "adguard/adguardhome:latest"
}

variable "dns_port" {
  description = "Host port for the DNS server (TCP and UDP)."
  type        = number
  default     = 53
}

variable "setup_port" {
  description = "Host port for the first-run setup wizard."
  type        = number
  default     = 3000
}

variable "web_port" {
  description = "Host port for the admin dashboard (choose this same value in the setup wizard)."
  type        = number
  default     = 80
}

variable "work_volume" {
  description = "Named volume for runtime data — query log, stats, filters (/opt/adguardhome/work)."
  type        = string
  default     = "adguardhome_work"
}

variable "conf_volume" {
  description = "Named volume for the configuration file (/opt/adguardhome/conf)."
  type        = string
  default     = "adguardhome_conf"
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
