variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "alertmanager"
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
  description = "The Alertmanager container image. Pin a tag in production."
  type        = string
  default     = "prom/alertmanager:latest"
}

variable "port" {
  description = "Host port for the Alertmanager UI / API. Point Prometheus's alerting config at this."
  type        = number
  default     = 9093
}

variable "config" {
  description = "Full alertmanager.yml contents. The default is a minimal valid config that drops alerts to a no-op receiver — replace it with your real routes/receivers (email, Slack, webhook to the ntfy/gotify packs, …)."
  type        = string
  default     = <<-EOT
    route:
      receiver: default
      group_by: ['alertname']
    receivers:
      - name: default
  EOT
}

variable "data_volume" {
  description = "Docker named volume for /alertmanager (silences + notification log). A fresh volume inherits the image's dir ownership (uid 65534)."
  type        = string
  default     = "alertmanager_data"
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
    cpu    = 200
    memory = 128
  }
}
