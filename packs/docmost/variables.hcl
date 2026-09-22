variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "docmost"
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

# --- Docmost --------------------------------------------------------------

variable "image" {
  description = "The Docmost container image. Pin a tag in production."
  type        = string
  default     = "docmost/docmost:latest"
}

variable "port" {
  description = "Host port for the Docmost web app. Default 3007 to avoid other packs on 3000-3006."
  type        = number
  default     = 3007
}

variable "app_secret" {
  description = "Secret key for sessions/tokens — at least 32 characters. CHANGE THIS (e.g. `openssl rand -hex 32`) and keep it stable."
  type        = string
  default     = "CHANGE_ME_docmost_app_secret_min_32_characters_long"
}

variable "app_url" {
  description = "Public URL Docmost is served at (e.g. https://docs.example.com), used for links/email. Empty = leave unset (uses request host)."
  type        = string
  default     = ""
}

variable "docmost_resources" {
  description = "Resources for the Docmost task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

# --- Bundled dependencies -------------------------------------------------

variable "postgres_image" {
  description = "PostgreSQL image backing Docmost."
  type        = string
  default     = "postgres:16-alpine"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on. Docmost connects on 127.0.0.1."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Docmost Postgres user. CHANGE THIS. (DB name and user are both \"docmost\".)"
  type        = string
  default     = "docmost"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir (pages, spaces, users). Back it up."
  type        = string
  default     = "docmost_db_data"
}

variable "redis_image" {
  description = "Redis image (used for queues/websockets; ephemeral, no volume)."
  type        = string
  default     = "redis:7-alpine"
}

variable "redis_port" {
  description = "Host port Redis listens on."
  type        = number
  default     = 6379
}

variable "storage_volume" {
  description = "Docker named volume for /app/data/storage (uploaded attachments/images). A prestart task chowns it to uid 1000. Back it up."
  type        = string
  default     = "docmost_storage"
}

variable "postgres_resources" {
  description = "Resources for the PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

# --- Placement ------------------------------------------------------------

variable "constraints" {
  description = "Placement constraints — pin the job to one node so the local volumes stay put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}
