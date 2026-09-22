variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "hedgedoc"
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
  description = "The HedgeDoc container image. Pin a tag in production."
  type        = string
  default     = "quay.io/hedgedoc/hedgedoc:1.10.3"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the HedgeDoc web UI (CMD_PORT)."
  type        = number
  default     = 3011
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the HedgeDoc PostgreSQL user."
  type        = string
  default     = "hedgedoc"
}

variable "domain" {
  description = "Domain (or host IP) HedgeDoc is reached at (CMD_DOMAIN), no protocol/port. Empty = localhost. Set this to the real host/domain so real-time sync and links work for remote clients."
  type        = string
  default     = ""
}

variable "allow_anonymous" {
  description = "Allow anonymous (no-login) note creation and editing (CMD_ALLOW_ANONYMOUS)."
  type        = bool
  default     = true
}

variable "uid" {
  description = "UID HedgeDoc runs as. The uploads volume is chown'd to this at startup."
  type        = number
  default     = 10000
}

variable "uploads_volume" {
  description = "Named volume for uploaded images/files (/hedgedoc/public/uploads)."
  type        = string
  default     = "hedgedoc_uploads"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all notes."
  type        = string
  default     = "hedgedoc_db_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the HedgeDoc app task."
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
