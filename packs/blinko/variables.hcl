variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "blinko"
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
  description = "The Blinko container image. Pin a tag in production."
  type        = string
  default     = "blinkospace/blinko:latest"
}

variable "port" {
  description = "Host port for the Blinko web UI."
  type        = number
  default     = 1111
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16"
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL (loopback only)."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Blinko database user. CHANGE THIS."
  type        = string
  default     = "change-me-blinko-db"
}

variable "data_volume" {
  description = "Named volume mounted at /app/.blinko (uploaded files)."
  type        = string
  default     = "blinko_data"
}

variable "db_data_volume" {
  description = "Named volume for the PostgreSQL data directory (holds your notes)."
  type        = string
  default     = "blinko_db"
}

variable "db_resources" {
  description = "Resources for the PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
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
