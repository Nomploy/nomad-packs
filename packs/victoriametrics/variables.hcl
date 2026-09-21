variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "victoriametrics"
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
  description = "The VictoriaMetrics single-node image. Pin a tag in production."
  type        = string
  default     = "victoriametrics/victoria-metrics:latest"
}

variable "port" {
  description = "Host port for the HTTP API (ingestion, PromQL/MetricsQL queries, vmui at /vmui)."
  type        = number
  default     = 8428
}

variable "retention" {
  description = "How long to keep data (VictoriaMetrics -retentionPeriod). Number = months (e.g. \"3\"), or use a suffix like \"30d\", \"1y\"."
  type        = string
  default     = "3"
}

variable "data_volume" {
  description = "Docker named volume for /victoria-metrics-data (the time-series storage). VictoriaMetrics runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "victoriametrics_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local storage volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources. Raise for high ingestion / long retention."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
