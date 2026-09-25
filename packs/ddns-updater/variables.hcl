variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ddns-updater"
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
  description = "The DDNS Updater container image. Pin a tag in production."
  type        = string
  default     = "qmcgaw/ddns-updater:latest"
}

variable "port" {
  description = "Host port for the DDNS Updater web UI."
  type        = number
  default     = 8000
}

variable "data_volume" {
  description = "Named volume mounted at /updater/data (holds config.json and the update history)."
  type        = string
  default     = "ddns_updater_data"
}

variable "config_json" {
  description = "Optional inline JSON config (the CONFIG env), e.g. {\"settings\":[{\"provider\":\"cloudflare\",\"domain\":\"example.com\",...}]}. Takes precedence over /updater/data/config.json. Leave empty to instead edit config.json in the data volume."
  type        = string
  default     = ""
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
    cpu    = 300
    memory = 256
  }
}
