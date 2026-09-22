variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "victoria-logs"
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
  description = "The VictoriaLogs container image. Pin a tag in production."
  type        = string
  default     = "victoriametrics/victoria-logs:latest"
}

variable "port" {
  description = "Host port for the HTTP API + UI (ingestion, LogsQL queries; UI at /select/vmui)."
  type        = number
  default     = 9428
}

variable "retention" {
  description = "How long to keep logs (-retentionPeriod), e.g. \"7d\", \"30d\", \"1y\"."
  type        = string
  default     = "30d"
}

variable "data_volume" {
  description = "Docker named volume for /victoria-logs-data (the log storage). VictoriaLogs runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "victoria_logs_data"
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
  description = "The task resources. Raise for high log ingestion / long retention."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
