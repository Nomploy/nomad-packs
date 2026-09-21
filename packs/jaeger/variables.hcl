variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "jaeger"
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
  description = "The Jaeger all-in-one container image. Pin a tag in production."
  type        = string
  default     = "jaegertracing/all-in-one:latest"
}

variable "ui_port" {
  description = "Host port for the Jaeger query web UI."
  type        = number
  default     = 16686
}

variable "otlp_grpc_port" {
  description = "Host port for the OTLP gRPC receiver — point your OpenTelemetry SDK/collector exporter here."
  type        = number
  default     = 4317
}

variable "otlp_http_port" {
  description = "Host port for the OTLP HTTP receiver."
  type        = number
  default     = 4318
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
  description = "The task resources. In-memory traces use RAM — raise memory to keep more."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
