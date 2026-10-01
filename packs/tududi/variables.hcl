variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "tududi"
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
  description = "The Tududi container image. Pin a tag in production."
  type        = string
  default     = "chrisvel/tududi:latest"
}

variable "port" {
  description = "Host port for the Tududi web UI."
  type        = number
  default     = 3002
}

variable "admin_email" {
  description = "Email of the admin account seeded on first start."
  type        = string
  default     = "admin@example.com"
}

variable "admin_password" {
  description = "Password of the admin account seeded on first start. CHANGE THIS."
  type        = string
  default     = "tududi_change_me"
}

variable "session_secret" {
  description = "Secret used to sign sessions (openssl rand -hex 64). CHANGE THIS."
  type        = string
  default     = "change_me_to_a_long_random_session_secret_0000"
}

variable "allowed_origins" {
  description = "Comma-separated origins allowed to reach the API. Set to your public URL."
  type        = string
  default     = "http://localhost:3002"
}

variable "trust_proxy" {
  description = "Set true when running behind a reverse proxy (e.g. Traefik) so secure cookies work."
  type        = string
  default     = "true"
}

variable "db_volume" {
  description = "Named volume for the SQLite database (/app/db)."
  type        = string
  default     = "tududi_db"
}

variable "uploads_volume" {
  description = "Named volume for uploaded files (/app/uploads)."
  type        = string
  default     = "tududi_uploads"
}

variable "backups_volume" {
  description = "Named volume for backups (/app/backups)."
  type        = string
  default     = "tududi_backups"
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
    memory = 384
  }
}
