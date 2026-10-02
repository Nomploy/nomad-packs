variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "gogs"
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
  description = "The Gogs container image. Pin a tag in production."
  type        = string
  default     = "gogs/gogs:latest"
}

variable "http_port" {
  description = "Host port for the Gogs web UI."
  type        = number
  default     = 3000
}

variable "ssh_port" {
  description = "Host port for git-over-SSH. Avoid 22 (the host's own sshd); Gogs listens here and advertises it in clone URLs."
  type        = number
  default     = 2222
}

variable "data_volume" {
  description = "Named volume for Gogs data: repositories, SQLite DB and config (/data)."
  type        = string
  default     = "gogs_data"
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
