variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "authentik"
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

# --- authentik ------------------------------------------------------------

variable "image" {
  description = "The authentik server/worker image (both tasks use it). Pin a tag in production."
  type        = string
  default     = "ghcr.io/goauthentik/server:latest"
}

variable "port" {
  description = "Host port for the authentik web UI / API."
  type        = number
  default     = 9000
}

variable "secret_key" {
  description = "AUTHENTIK_SECRET_KEY — a long random value used to sign sessions/tokens. CHANGE THIS (e.g. `openssl rand -base64 50`) and keep it stable."
  type        = string
  default     = "CHANGE_ME_authentik_secret_key_use_openssl_rand_base64_50"
}

variable "bootstrap_password" {
  description = "Initial password for the built-in `akadmin` user, set on first start. CHANGE THIS. Empty = you set the password via the first-run flow at /if/flow/initial-setup/."
  type        = string
  default     = ""
}

variable "bootstrap_email" {
  description = "Email for the initial akadmin user (used with bootstrap_password)."
  type        = string
  default     = "admin@example.com"
}

variable "server_resources" {
  description = "Resources for the authentik server task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "worker_resources" {
  description = "Resources for the authentik worker task."
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
  description = "PostgreSQL image backing authentik."
  type        = string
  default     = "postgres:16-alpine"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on. authentik connects on 127.0.0.1."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the authentik Postgres user. CHANGE THIS. (DB name and user are both \"authentik\".)"
  type        = string
  default     = "authentik"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir (users, apps, flows). Back it up."
  type        = string
  default     = "authentik_db_data"
}

variable "redis_image" {
  description = "Redis image (cache/queues; ephemeral, no volume)."
  type        = string
  default     = "redis:7-alpine"
}

variable "redis_port" {
  description = "Host port Redis listens on."
  type        = number
  default     = 6379
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
  description = "Placement constraints — pin the job to one node so the Postgres local volume stays put (single all-in-one alloc). On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}
