variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "osctrl"
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

# --- Images -----------------------------------------------------------------

variable "tls_image" {
  description = "osctrl-tls image (the osquery TLS endpoint). Pin a tag in production."
  type        = string
  default     = "jmpsec/osctrl-tls:0.6.2"
}

variable "api_image" {
  description = "osctrl-api image (the REST/JWT API the admin UI talks to). Pin a tag in production."
  type        = string
  default     = "jmpsec/osctrl-api:0.6.2"
}

variable "frontend_image" {
  description = "osctrl-frontend image (nginx serving the React admin SPA + /api proxy). Pin a tag in production."
  type        = string
  default     = "jmpsec/osctrl-frontend:0.6.2"
}

variable "cli_image" {
  description = "osctrl-cli image, used by the init task to create the environment and admin user. Pin a tag in production."
  type        = string
  default     = "jmpsec/osctrl-cli:0.6.2"
}

variable "postgres_image" {
  description = "PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "redis_image" {
  description = "Redis image for the bundled cache (ephemeral — no volume)."
  type        = string
  default     = "redis:7-alpine"
}

# --- Ports ------------------------------------------------------------------

variable "frontend_port" {
  description = "Host port for the admin web UI (front this with a reverse proxy for TLS). Default 9001."
  type        = number
  default     = 9001
}

variable "tls_port" {
  description = "Host port for the osquery TLS endpoint that agents enroll/report to. Default 9000."
  type        = number
  default     = 9000
}

variable "api_port" {
  description = "Host port for the osctrl API. Default 9002 (the frontend proxies /api to it on 127.0.0.1)."
  type        = number
  default     = 9002
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL."
  type        = number
  default     = 5432
}

variable "redis_port" {
  description = "Host port for the bundled Redis."
  type        = number
  default     = 6379
}

# --- Database ---------------------------------------------------------------

variable "db_name" {
  description = "PostgreSQL database name."
  type        = string
  default     = "osctrl"
}

variable "db_user" {
  description = "PostgreSQL username."
  type        = string
  default     = "osctrl"
}

variable "db_password" {
  description = "PostgreSQL password. CHANGE THIS before deploying."
  type        = string
  default     = "osctrl"
}

variable "db_data_volume" {
  description = "Named Docker volume for PostgreSQL data (the critical state — back it up)."
  type        = string
  default     = "osctrl_db_data"
}

# --- osctrl app -------------------------------------------------------------

variable "jwt_secret" {
  description = "JWT signing secret for the API (min 64 chars). CHANGE THIS to a long random value."
  type        = string
  default     = "CHANGE-ME-to-a-64-char-random-secret-0000000000000000000000000000"
}

variable "admin_user" {
  description = "Username of the auto-created osctrl admin."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Password of the auto-created osctrl admin. CHANGE THIS before deploying."
  type        = string
  default     = "Changeme123!"
}

variable "env_name" {
  description = "Name of the osctrl environment created on first boot (osquery nodes enroll into it)."
  type        = string
  default     = "prod"
}

variable "osquery_host" {
  description = "Public hostname osquery agents use to reach the TLS endpoint (stored on the environment). Set this to the domain you point at tls_port via your reverse proxy."
  type        = string
  default     = "osctrl.example.com"
}

variable "osquery_version" {
  description = "osquery schema version the API ships at /opt/osctrl/data/<version>.json (used by the query editor)."
  type        = string
  default     = "5.24.0"
}

variable "trusted_proxies" {
  description = "CIDRs whose X-Forwarded-For/X-Real-IP headers are honored (so node IPs are the real client, not the proxy). Covers loopback + private ranges by default."
  type        = string
  default     = "127.0.0.1/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
}

# --- Placement & resources --------------------------------------------------

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "tls_resources" {
  description = "Resources for the osctrl-tls task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}

variable "api_resources" {
  description = "Resources for the osctrl-api task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}

variable "postgres_resources" {
  description = "Resources for the bundled PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
