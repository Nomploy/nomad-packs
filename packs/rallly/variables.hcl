variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "rallly"
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
  description = "The Rallly container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/lukevella/rallly:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the Rallly web UI."
  type        = number
  default     = 3010
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Rallly PostgreSQL user."
  type        = string
  default     = "rallly"
}

variable "base_url" {
  description = "Public base URL Rallly is served at (NEXT_PUBLIC_BASE_URL). Empty = http://localhost:<port>. Set this to the real host/domain — links in emails use it."
  type        = string
  default     = ""
}

variable "secret_password" {
  description = "Secret used to encrypt user sessions (SECRET_PASSWORD). Must be at least 32 characters. Generate with: openssl rand -hex 32."
  type        = string
  default     = "change-me-to-a-random-32-char-secret-value"
}

variable "support_email" {
  description = "From/support address used for outgoing email and shown to users (SUPPORT_EMAIL)."
  type        = string
  default     = "support@nomploy.local"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all polls."
  type        = string
  default     = "rallly_db_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Rallly app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
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
