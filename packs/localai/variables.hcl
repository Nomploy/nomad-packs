variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "localai"
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
  description = "The LocalAI container image. Pin a tag in production."
  type        = string
  default     = "localai/localai:latest"
}

variable "port" {
  description = "Host port for the LocalAI web UI."
  type        = number
  default     = 8080
}

variable "data_volume" {
  description = "Named volume mounted at /models (downloaded model files)."
  type        = string
  default     = "localai_data"
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
    cpu    = 4000
    memory = 4096
  }
}
