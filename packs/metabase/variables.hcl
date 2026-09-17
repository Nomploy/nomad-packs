variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "metabase"
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

# --- Metabase -------------------------------------------------------------

variable "image" {
  description = "The Metabase container image. Pin a tag in production."
  type        = string
  default     = "metabase/metabase:latest"
}

variable "port" {
  description = "Host port for the Metabase web UI. Default 3003 to avoid the nomploy panel (:3000), grafana (:3001) and gitea (:3002)."
  type        = number
  default     = 3003
}

variable "site_url" {
  description = "Public URL Metabase is served at (e.g. https://bi.example.com), set when fronting it with a domain. Empty = leave unset."
  type        = string
  default     = ""
}

variable "encryption_key" {
  description = "Optional key used to encrypt stored data-source credentials at rest (MB_ENCRYPTION_SECRET_KEY). Recommended for production; treat it as a secret and keep it stable (changing it orphans encrypted secrets). Empty = unset."
  type        = string
  default     = ""
}

variable "metabase_resources" {
  description = "Resources for the Metabase (JVM) task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
  }
}

# --- PostgreSQL (bundled application DB) ----------------------------------

variable "postgres_image" {
  description = "PostgreSQL image backing Metabase's application data."
  type        = string
  default     = "postgres:16-alpine"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on. Metabase connects on 127.0.0.1 (same host network namespace)."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Metabase application DB user. CHANGE THIS. (DB name and user are both \"metabase\".)"
  type        = string
  default     = "metabase"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir. This is Metabase's state (dashboards, questions, users, data-source configs) — back it up. A fresh volume inherits the image's data-dir ownership."
  type        = string
  default     = "metabase_db_data"
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
