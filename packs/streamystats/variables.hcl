variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "streamystats"
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
  description = "The Streamystats container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/fredrikburmester/streamystats-aio:latest"
}

variable "port" {
  description = "Host port for the Streamystats web UI."
  type        = number
  default     = 3000
}

variable "data_volume" {
  description = "Named volume mounted at /var/lib/postgresql/data — the bundled PostgreSQL data (holds all stats)."
  type        = string
  default     = "streamystats_data"
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "change-me-streamystats-db"
}

variable "session_secret" {
  description = "Secret used to sign sessions (SESSION_SECRET). CHANGE THIS. Generate with: openssl rand -hex 64."
  type        = string
  default     = "change-me-openssl-rand-hex-64"
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
    cpu    = 700
    memory = 768
  }
}
