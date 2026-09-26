variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kokoro"
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
  description = "The Kokoro TTS container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/remsky/kokoro-fastapi-cpu:latest"
}

variable "port" {
  description = "Host port for the Kokoro TTS API / web UI. Fixed at 8880 inside the image."
  type        = number
  default     = 8880
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
    cpu    = 2000
    memory = 2048
  }
}
