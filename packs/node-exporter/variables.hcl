variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "node-exporter"
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
  description = "The Node Exporter container image. Pin a tag in production."
  type        = string
  default     = "quay.io/prometheus/node-exporter:latest"
}

variable "port" {
  description = "Host port for the metrics endpoint (--web.listen-address)."
  type        = number
  default     = 9100
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
  description = "Resources for the Node Exporter task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 100
    memory = 64
  }
}
