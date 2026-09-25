variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "commafeed"
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
  description = "The CommaFeed container image. Pin a tag in production."
  type        = string
  default     = "athou/commafeed:latest-h2"
}

variable "port" {
  description = "Host port for the CommaFeed web UI."
  type        = number
  default     = 8082
}

variable "data_volume" {
  description = "Named volume mounted at /root/.local/share/commafeed."
  type        = string
  default     = "commafeed_data"
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
    cpu    = 500
    memory = 512
  }
}
