variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "certimate"
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
  description = "The Certimate container image. Pin a tag in production."
  type        = string
  default     = "certimate/certimate:latest"
}

variable "port" {
  description = "Host port for the Certimate web UI."
  type        = number
  default     = 8090
}

variable "data_volume" {
  description = "Named volume for Certimate's database and state (PocketBase pb_data)."
  type        = string
  default     = "certimate_data"
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
  description = "Resources for the Certimate task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
