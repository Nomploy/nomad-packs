variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "apprise"
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
  description = "The Apprise API container image. Pin a tag in production."
  type        = string
  default     = "caronc/apprise:latest"
}

variable "port" {
  description = "Host port for the Apprise API / web UI. The container listens on 8000."
  type        = number
  default     = 8000
}

variable "stateful_mode" {
  description = "Persistent config storage mode (APPRISE_STATEFUL_MODE): 'simple', 'hash', or 'disabled'."
  type        = string
  default     = "simple"
}

variable "worker_count" {
  description = "Number of API workers (APPRISE_WORKER_COUNT)."
  type        = number
  default     = 1
}

variable "config_volume" {
  description = "Named volume for saved notification configs (/config)."
  type        = string
  default     = "apprise_config"
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
  description = "Resources for the Apprise task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
