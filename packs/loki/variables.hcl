variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "loki"
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

variable "loki_image" {
  description = "Loki image. Loki's config schema is version-sensitive — pin a 3.x tag in production (this pack's config targets Loki 3.x: tsdb + schema v13)."
  type        = string
  default     = "grafana/loki:latest"
}

variable "alloy_image" {
  description = "Grafana Alloy image (the log shipper; the modern replacement for the now-EOL Promtail)."
  type        = string
  default     = "grafana/alloy:latest"
}

variable "loki_port" {
  description = "Host port for Loki's HTTP API (push + query). Add this as a Grafana datasource."
  type        = number
  default     = 3100
}

variable "alloy_port" {
  description = "Host port for Alloy's HTTP UI/debug endpoint."
  type        = number
  default     = 12345
}

variable "enable_alloy" {
  description = "Run the bundled Alloy shipper that tails this node's Docker container logs into Loki. Set false to run Loki alone and push from your own agents."
  type        = bool
  default     = true
}

variable "retention" {
  description = "How long Loki keeps logs, as a Go duration in HOURS (e.g. 168h = 7d, 336h = 14d, 720h = 30d). The compactor enforces it."
  type        = string
  default     = "336h"
}

variable "loki_data_volume" {
  description = "Docker named volume for /loki (chunks + index). Loki runs as uid 10001; a prestart task chowns the volume so it can write."
  type        = string
  default     = "loki_data"
}

variable "constraints" {
  description = "Placement constraints — pin the job to one node so the local volume stays put and Alloy tails that node's containers. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "loki_resources" {
  description = "Resources for the Loki task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "alloy_resources" {
  description = "Resources for the Alloy shipper task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 256
  }
}
