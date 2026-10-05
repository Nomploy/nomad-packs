variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "checkcle"
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
  description = "The CheckCle container image. Pin a tag in production."
  type        = string
  default     = "operacle/checkcle:latest"
}

variable "port" {
  description = "Host port for the CheckCle web UI."
  type        = number
  default     = 8090
}

variable "data_volume" {
  description = "Named volume for CheckCle's database and state (PocketBase pb_data)."
  type        = string
  default     = "checkcle_data"
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
  description = "Resources for the CheckCle task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 400
    memory = 512
  }
}
