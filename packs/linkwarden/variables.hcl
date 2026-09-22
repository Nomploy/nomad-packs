variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "linkwarden"
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
  description = "The Linkwarden container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/linkwarden/linkwarden:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the Linkwarden web UI (PORT)."
  type        = number
  default     = 3012
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Linkwarden PostgreSQL user."
  type        = string
  default     = "linkwarden"
}

variable "base_url" {
  description = "Public base URL Linkwarden is served at (used for NEXTAUTH_URL). Empty = http://localhost:<port>. Set this to the real host/domain."
  type        = string
  default     = ""
}

variable "nextauth_secret" {
  description = "Secret used to sign auth sessions (NEXTAUTH_SECRET). Generate a long random value (openssl rand -base64 32)."
  type        = string
  default     = "change-me-to-a-long-random-secret"
}

variable "data_volume" {
  description = "Named volume for archived link snapshots — screenshots, PDFs (/data/data)."
  type        = string
  default     = "linkwarden_data"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all bookmarks."
  type        = string
  default     = "linkwarden_db_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Linkwarden app task (link archiving runs a headless browser)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "postgres_resources" {
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
