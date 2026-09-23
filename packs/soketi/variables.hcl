variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "soketi"
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
  description = "The soketi container image. Pin a tag in production."
  type        = string
  default     = "quay.io/soketi/soketi:latest-16-alpine"
}

variable "port" {
  description = "Host port for the WebSocket server (SOKETI_PORT)."
  type        = number
  default     = 6001
}

variable "metrics_port" {
  description = "Host port for the Prometheus metrics endpoint."
  type        = number
  default     = 9601
}

variable "app_id" {
  description = "Default app id (SOKETI_DEFAULT_APP_ID)."
  type        = string
  default     = "app-id"
}

variable "app_key" {
  description = "Default app key (SOKETI_DEFAULT_APP_KEY). CHANGE THIS."
  type        = string
  default     = "app-key"
}

variable "app_secret" {
  description = "Default app secret (SOKETI_DEFAULT_APP_SECRET). CHANGE THIS."
  type        = string
  default     = "app-secret"
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
    cpu    = 300
    memory = 256
  }
}
