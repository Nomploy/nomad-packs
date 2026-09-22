variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "influxdb"
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
  description = "The InfluxDB 2 container image. Pin a tag in production."
  type        = string
  default     = "influxdb:2"
}

variable "port" {
  description = "Host port for the InfluxDB HTTP API + UI."
  type        = number
  default     = 8086
}

variable "admin_user" {
  description = "Initial admin username (created on first boot in setup mode)."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Initial admin password (min 8 chars). CHANGE THIS."
  type        = string
  default     = "changeme123"
}

variable "org" {
  description = "Initial organization name."
  type        = string
  default     = "nomploy"
}

variable "bucket" {
  description = "Initial bucket name."
  type        = string
  default     = "default"
}

variable "admin_token" {
  description = "Initial admin API token (clients authenticate with it). CHANGE THIS — treat it as a secret."
  type        = string
  default     = "changeme-admin-token"
}

variable "data_volume" {
  description = "Docker named volume for /var/lib/influxdb2 (time-series data + config). InfluxDB runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "influxdb_data"
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
    cpu    = 500
    memory = 512
  }
}
