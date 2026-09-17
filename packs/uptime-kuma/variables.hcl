variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "uptime-kuma"
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
  description = "The Uptime Kuma container image."
  type        = string
  default     = "louislam/uptime-kuma:1"
}

variable "port" {
  description = "Host port for the Uptime Kuma web UI. Default 3001 is Uptime Kuma's own default — change it if it clashes with the grafana/monitoring packs on the same node."
  type        = number
  default     = 3001
}

variable "data_volume" {
  description = "Docker named volume for /app/data (SQLite DB, config, uploaded icons). All of Uptime Kuma's state."
  type        = string
  default     = "uptime_kuma_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
