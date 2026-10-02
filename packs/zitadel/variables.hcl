variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "zitadel"
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
  description = "The ZITADEL container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/zitadel/zitadel:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the ZITADEL console / API."
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "zitadel_change_me"
}

variable "masterkey" {
  description = "Exactly 32-character key used to encrypt secrets at rest. CHANGE THIS and keep it stable."
  type        = string
  default     = "ChangeMeToARandom32CharMasterKey"
}

variable "external_domain" {
  description = "Public domain/host ZITADEL is reached at (no scheme). Must match how users access it."
  type        = string
  default     = "localhost"
}

variable "external_secure" {
  description = "Set true when served over HTTPS (e.g. behind Traefik); false for plain HTTP."
  type        = string
  default     = "false"
}

variable "admin_username" {
  description = "First-instance admin username (login is <username>@zitadel.<external_domain>)."
  type        = string
  default     = "zitadel-admin"
}

variable "admin_password" {
  description = "First-instance admin password. CHANGE THIS (needs upper/lower/number/symbol, 8+)."
  type        = string
  default     = "Password1!"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "zitadel_db_data"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the ZITADEL app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "db_resources" {
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
