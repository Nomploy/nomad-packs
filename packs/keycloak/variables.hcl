variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "keycloak"
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

# --- Keycloak -------------------------------------------------------------

variable "image" {
  description = "The Keycloak container image (26.x). Pin a tag in production."
  type        = string
  default     = "quay.io/keycloak/keycloak:latest"
}

variable "port" {
  description = "Host port for Keycloak's HTTP listener. Serves plain HTTP — front it with a reverse proxy (Traefik) for TLS."
  type        = number
  default     = 8080
}

variable "hostname" {
  description = "Public hostname/URL Keycloak is served at (e.g. https://auth.example.com), set when fronting it with a domain. Empty = hostname-strict is off and Keycloak infers it from the request (fine for IP access / testing)."
  type        = string
  default     = ""
}

variable "admin_user" {
  description = "Bootstrap admin username, created on first start with an empty database."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Bootstrap admin password. CHANGE THIS. Only applied on first start (empty DB); rotate it in the console afterwards."
  type        = string
  default     = "admin"
}

variable "keycloak_resources" {
  description = "Resources for the Keycloak (JVM) task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

# --- PostgreSQL (bundled dependency) --------------------------------------

variable "postgres_image" {
  description = "PostgreSQL image backing Keycloak."
  type        = string
  default     = "postgres:16-alpine"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on. Keycloak connects on 127.0.0.1 (same host network namespace)."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Keycloak database user. CHANGE THIS. (DB name and user are both \"keycloak\".)"
  type        = string
  default     = "keycloak"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir. This is the critical state (realms, users, clients) — back it up. A fresh volume inherits the image's data-dir ownership so Postgres can write it."
  type        = string
  default     = "keycloak_db_data"
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
