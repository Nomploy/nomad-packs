variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "changedetection"
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
  description = "The changedetection.io container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/dgtlmoon/changedetection.io:latest"
}

variable "port" {
  description = "Host port for the changedetection.io web UI (PORT)."
  type        = number
  default     = 5001
}

variable "base_url" {
  description = "Public base URL used in notification links (BASE_URL). Empty = not set."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for all configuration and watch history (/datastore)."
  type        = string
  default     = "changedetection_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
    cpu    = 500
    memory = 512
  }
}
