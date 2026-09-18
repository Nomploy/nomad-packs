variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "plausible"
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

# --- Plausible ------------------------------------------------------------

variable "image" {
  description = "The Plausible Community Edition image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/plausible/community-edition:v3.0.1"
}

variable "port" {
  description = "Host port for the Plausible web UI (HTTP_PORT)."
  type        = number
  default     = 8000
}

variable "base_url" {
  description = "Public URL Plausible is served at (e.g. https://analytics.example.com). Used in links and the tracking snippet. Empty = http://localhost:<port>."
  type        = string
  default     = ""
}

variable "secret_key_base" {
  description = "Secret used to sign sessions — MUST be at least 64 characters. CHANGE THIS (e.g. `openssl rand -base64 64`) and keep it stable."
  type        = string
  default     = "CHANGE_ME_generate_with_openssl_rand_base64_64_at_least_64_chars_long!!"
}

variable "disable_registration" {
  description = "Registration policy: \"false\" (open — create the first/admin account, then lock down), \"true\" (no new accounts), or \"invite_only\"."
  type        = string
  default     = "false"
}

variable "plausible_resources" {
  description = "Resources for the Plausible task."
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
  description = "PostgreSQL image for Plausible's app database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Plausible Postgres user. CHANGE THIS. (DB name and user are both \"plausible\".)"
  type        = string
  default     = "plausible"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir (users, sites, settings). Back it up."
  type        = string
  default     = "plausible_db_data"
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

# --- ClickHouse (bundled, event store) ------------------------------------

variable "clickhouse_image" {
  description = "ClickHouse image for Plausible's event store. Pin to a version Plausible supports."
  type        = string
  default     = "clickhouse/clickhouse-server:24.12-alpine"
}

variable "clickhouse_port" {
  description = "Host port for ClickHouse's HTTP interface (Plausible connects here on 127.0.0.1)."
  type        = number
  default     = 8123
}

variable "clickhouse_data_volume" {
  description = "Docker named volume for /var/lib/clickhouse (the event data — the bulk of analytics). Back it up."
  type        = string
  default     = "plausible_ch_data"
}

variable "clickhouse_resources" {
  description = "Resources for the ClickHouse task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

# --- Placement ------------------------------------------------------------

variable "constraints" {
  description = "Placement constraints — pin the job to one node so the local volumes stay put (single all-in-one alloc). On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}
