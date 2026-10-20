variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "starring"
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
  description = "The Starring app image. Pin a version/sha in production."
  type        = string
  default     = "ghcr.io/pipozzz/starring:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database (Starring targets PostgreSQL 17). Only used when bundled_db = true."
  type        = string
  default     = "postgres:17-alpine"
}

variable "bundled_db" {
  description = "Run a bundled PostgreSQL inside this job (true), or connect to an external / managed database via database_url (false). With false, no postgres/wait-db tasks and no db port are generated."
  type        = bool
  default     = true
}

variable "database_url" {
  description = "External PostgreSQL connection string, used when bundled_db = false. e.g. postgres://user:pass@host:5432/starring."
  type        = string
  default     = ""
}

variable "port" {
  description = "Host port for the Starring web app (PORT)."
  type        = number
  default     = 4321
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Starring PostgreSQL user. CHANGE THIS."
  type        = string
  default     = "starring"
}

variable "better_auth_url" {
  description = "Public URL Starring is reachable at (BETTER_AUTH_URL). Empty = http://localhost:<port>. Set this to your real host/domain, e.g. https://app.example.com."
  type        = string
  default     = ""
}

variable "better_auth_secret" {
  description = "Secret that signs auth sessions (BETTER_AUTH_SECRET). CHANGE THIS and keep it STABLE. Generate with: openssl rand -hex 32."
  type        = string
  default     = "change-me-openssl-rand-hex-32"
}

variable "site_url" {
  description = "Optional public site URL (SITE_URL). Empty = unset."
  type        = string
  default     = ""
}

variable "allow_signup" {
  description = "Allow open sign-ups (ALLOW_SIGNUP). Leave false and sign in / invite instead."
  type        = bool
  default     = false
}

variable "password_auth" {
  description = "Enable email/password auth (AUTH_PASSWORD) so you can create the first user."
  type        = bool
  default     = true
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all data — back it up."
  type        = string
  default     = "starring_db_data"
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
  description = "Resources for the Starring app task."
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
