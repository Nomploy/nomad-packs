variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "directus"
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

# --- Directus -------------------------------------------------------------

variable "image" {
  description = "The Directus container image. Pin a tag in production."
  type        = string
  default     = "directus/directus:latest"
}

variable "port" {
  description = "Host port for the Directus app / API."
  type        = number
  default     = 8055
}

variable "key" {
  description = "Unique KEY for this instance (any random string). CHANGE THIS and keep it stable."
  type        = string
  default     = "CHANGE_ME_directus_key"
}

variable "secret" {
  description = "SECRET used to sign tokens (any random string). CHANGE THIS and keep it stable."
  type        = string
  default     = "CHANGE_ME_directus_secret"
}

variable "admin_email" {
  description = "First admin email, created on first boot."
  type        = string
  default     = "admin@example.com"
}

variable "admin_password" {
  description = "First admin password, created on first boot. CHANGE THIS."
  type        = string
  default     = "admin"
}

variable "public_url" {
  description = "Public URL Directus is served at (PUBLIC_URL), e.g. https://cms.example.com. Empty = leave unset."
  type        = string
  default     = ""
}

variable "uploads_volume" {
  description = "Docker named volume for /directus/uploads (files/assets). A prestart task chowns it to uid 1000 (the node user). Back it up."
  type        = string
  default     = "directus_uploads"
}

variable "directus_resources" {
  description = "Resources for the Directus task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

# --- PostgreSQL (bundled) -------------------------------------------------

variable "postgres_image" {
  description = "PostgreSQL image backing Directus."
  type        = string
  default     = "postgres:16-alpine"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on. Directus connects on 127.0.0.1."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Directus Postgres user. CHANGE THIS. (DB name and user are both \"directus\".)"
  type        = string
  default     = "directus"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir (collections, users, config). Back it up."
  type        = string
  default     = "directus_db_data"
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
