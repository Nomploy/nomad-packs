variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "shlink"
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
  description = "The Shlink app image. Pin a tag in production."
  type        = string
  default     = "shlinkio/shlink:stable"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the Shlink API / short-URL server. The container listens on 8080."
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Shlink PostgreSQL user."
  type        = string
  default     = "shlink"
}

variable "default_domain" {
  description = "The domain your short URLs use (DEFAULT_DOMAIN), e.g. s.example.com. Set this to your real domain."
  type        = string
  default     = "localhost"
}

variable "is_https_enabled" {
  description = "Whether short URLs should use https (IS_HTTPS_ENABLED). Set true when behind a TLS reverse proxy."
  type        = bool
  default     = false
}

variable "initial_api_key" {
  description = "API key created on first boot (INITIAL_API_KEY), used by the web client and CLI. CHANGE THIS."
  type        = string
  default     = "change-me-initial-api-key"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all short URLs and visits."
  type        = string
  default     = "shlink_db_data"
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
  description = "Resources for the Shlink app task."
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
