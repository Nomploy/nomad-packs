variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "watchyourlan"
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
  description = "The WatchYourLAN container image. Pin a tag in production."
  type        = string
  default     = "aceberg/watchyourlan:latest"
}

variable "port" {
  description = "Host port for the WatchYourLAN web UI."
  type        = number
  default     = 8840
}

variable "data_volume" {
  description = "Named volume mounted at /data/WatchYourLAN (the SQLite database)."
  type        = string
  default     = "watchyourlan_data"
}

variable "ifaces" {
  description = "Network interface(s) to scan, space-separated (IFACES). SET THIS to your host's real interface — run `ip -br link` to find it (e.g. \"eth0\" or \"eth0 eth1\")."
  type        = string
  default     = "eth0"
}

variable "timeout" {
  description = "Seconds between network scans (TIMEOUT)."
  type        = number
  default     = 60
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
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
