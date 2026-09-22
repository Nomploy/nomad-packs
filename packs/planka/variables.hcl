variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "planka"
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
  description = "The Planka container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/plankanban/planka:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the Planka web UI."
  type        = number
  default     = 1337
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Planka PostgreSQL user."
  type        = string
  default     = "planka"
}

variable "base_url" {
  description = "Public base URL Planka is served at (BASE_URL). Empty = http://localhost:<port>. Set this to the real host/domain."
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "Secret used to sign sessions (SECRET_KEY). Generate a long random value (openssl rand -hex 64)."
  type        = string
  default     = "change-me-to-a-long-random-secret-key"
}

variable "admin_email" {
  description = "Initial admin email (DEFAULT_ADMIN_EMAIL)."
  type        = string
  default     = "admin@nomploy.local"
}

variable "admin_username" {
  description = "Initial admin username (DEFAULT_ADMIN_USERNAME)."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Initial admin password (DEFAULT_ADMIN_PASSWORD). CHANGE THIS. Note: it is re-applied on every boot — remove it after first login to let UI changes stick."
  type        = string
  default     = "changeme-please"
}

variable "admin_name" {
  description = "Initial admin display name (DEFAULT_ADMIN_NAME)."
  type        = string
  default     = "Admin"
}

variable "avatars_volume" {
  description = "Named volume for user avatars (/app/public/user-avatars)."
  type        = string
  default     = "planka_avatars"
}

variable "backgrounds_volume" {
  description = "Named volume for project backgrounds (/app/public/project-background-images)."
  type        = string
  default     = "planka_backgrounds"
}

variable "attachments_volume" {
  description = "Named volume for attachments (/app/private/attachments)."
  type        = string
  default     = "planka_attachments"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all boards."
  type        = string
  default     = "planka_db_data"
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
  description = "Resources for the Planka app task."
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
