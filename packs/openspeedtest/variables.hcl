variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "openspeedtest"
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
  description = "The OpenSpeedTest container image. Pin a tag in production."
  type        = string
  default     = "openspeedtest/latest:latest"
}

variable "port" {
  description = "Host port for the HTTP web UI (HTTP_PORT)."
  type        = number
  default     = 3018
}

variable "https_port" {
  description = "Host port for the HTTPS web UI (HTTPS_PORT). Accurate results above ~1 Gbps need HTTPS/HTTP2."
  type        = number
  default     = 3019
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
  description = "Resources for the OpenSpeedTest task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 128
  }
}
