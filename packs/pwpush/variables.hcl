variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "pwpush"
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
  description = "The Password Pusher container image. Pin a tag in production."
  type        = string
  default     = "pglombardo/pwpush:latest"
}

variable "port" {
  description = "Host port for the Password Pusher web UI."
  type        = number
  default     = 5100
}

variable "storage_volume" {
  description = "Named volume for the SQLite database and uploads (/opt/PasswordPusher/storage)."
  type        = string
  default     = "pwpush_storage"
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
  description = "Resources for the Password Pusher task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 400
    memory = 512
  }
}
