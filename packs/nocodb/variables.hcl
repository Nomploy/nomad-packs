variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "nocodb"
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

# --- NocoDB ---------------------------------------------------------------

variable "image" {
  description = "The NocoDB container image. Pin a tag in production."
  type        = string
  default     = "nocodb/nocodb:latest"
}

variable "port" {
  description = "Host port for the NocoDB web UI / API."
  type        = number
  default     = 8098
}

variable "public_url" {
  description = "Public URL NocoDB is served at (NC_PUBLIC_URL), used in emails/links. Empty = leave unset."
  type        = string
  default     = ""
}

variable "jwt_secret" {
  description = "Secret used to sign auth tokens (NC_AUTH_JWT_SECRET). Set a random string and keep it stable. Empty = NocoDB generates one."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /usr/app/data (uploads/attachments). NocoDB runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "nocodb_data"
}

variable "nocodb_resources" {
  description = "Resources for the NocoDB task."
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
  description = "PostgreSQL image backing NocoDB's metadata."
  type        = string
  default     = "postgres:16-alpine"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on. NocoDB connects on 127.0.0.1."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for NocoDB's Postgres user. CHANGE THIS. (DB name and user are both \"nocodb\".)"
  type        = string
  default     = "nocodb"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir (bases, views, users). Back it up."
  type        = string
  default     = "nocodb_db_data"
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
