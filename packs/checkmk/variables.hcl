variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "checkmk"
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
  description = "The Checkmk Raw container image. Pin a tag in production."
  type        = string
  default     = "checkmk/check-mk-raw:2.4.0-latest"
}

variable "port" {
  description = "Host port for the Checkmk web UI."
  type        = number
  default     = 5000
}

variable "admin_password" {
  description = "Password for the cmkadmin user, set on first start. CHANGE THIS."
  type        = string
  default     = "checkmk_change_me"
}

variable "timezone" {
  description = "Timezone for the container (e.g. Europe/Bratislava)."
  type        = string
  default     = "UTC"
}

variable "data_volume" {
  description = "Named volume for Checkmk sites, config and monitoring data (/omd/sites)."
  type        = string
  default     = "checkmk_sites"
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
    cpu    = 1000
    memory = 2048
  }
}
