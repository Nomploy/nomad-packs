variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "windmill"
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
  description = "The Windmill container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/windmill-labs/windmill:latest"
}

variable "port" {
  description = "Host port for the Windmill web UI."
  type        = number
  default     = 8000
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
  description = "Password for the Windmill database user. CHANGE THIS."
  type        = string
  default     = "change-me-windmill-db"
}

variable "base_url" {
  description = "Public URL Windmill is reached at (BASE_URL). Empty = http://localhost:<port>. Set to your real host/domain."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume mounted at /tmp/windmill — the worker dependency cache."
  type        = string
  default     = "windmill_cache"
}

variable "db_data_volume" {
  description = "Named volume for the PostgreSQL data directory (holds all Windmill state)."
  type        = string
  default     = "windmill_db"
}

variable "db_resources" {
  description = "Resources for the PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 400
    memory = 512
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
  description = "Resources for the Windmill task (server + embedded worker)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
