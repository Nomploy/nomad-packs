variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dawarich"
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
  description = "The Dawarich container image (used for both web and Sidekiq). Pin a tag in production."
  type        = string
  default     = "freikin/dawarich:latest"
}

variable "postgres_image" {
  description = "The PostGIS image for the bundled database. Use imresamu/postgis:17-3.5-alpine on ARM."
  type        = string
  default     = "postgis/postgis:17-3.5-alpine"
}

variable "redis_image" {
  description = "The Redis image for the bundled queue backend."
  type        = string
  default     = "redis:7.4-alpine"
}

variable "port" {
  description = "Host port for the Dawarich web UI."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Host port for the bundled PostGIS database."
  type        = number
  default     = 5432
}

variable "redis_port" {
  description = "Host port for the bundled Redis."
  type        = number
  default     = 6379
}

variable "db_password" {
  description = "Password for the bundled PostGIS database. CHANGE THIS."
  type        = string
  default     = "dawarich_change_me"
}

variable "secret_key_base" {
  description = "Rails SECRET_KEY_BASE used to sign sessions. CHANGE THIS to a long random value."
  type        = string
  default     = "change_me_to_a_long_random_secret_key_base_at_least_64_hex_chars_0000"
}

variable "time_zone" {
  description = "Application timezone (e.g. Europe/Bratislava)."
  type        = string
  default     = "UTC"
}

variable "db_data_volume" {
  description = "Named volume for PostGIS data."
  type        = string
  default     = "dawarich_db_data"
}

variable "redis_data_volume" {
  description = "Named volume for Redis data."
  type        = string
  default     = "dawarich_redis_data"
}

variable "public_volume" {
  description = "Named volume shared by web and Sidekiq for generated public assets (/var/app/public)."
  type        = string
  default     = "dawarich_public"
}

variable "watched_volume" {
  description = "Named volume for the watched imports folder (/var/app/tmp/imports/watched)."
  type        = string
  default     = "dawarich_watched"
}

variable "storage_volume" {
  description = "Named volume for uploaded files and storage (/var/app/storage)."
  type        = string
  default     = "dawarich_storage"
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
  description = "Resources for the web (Puma) task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
  }
}

variable "sidekiq_resources" {
  description = "Resources for the Sidekiq worker task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
  }
}

variable "db_resources" {
  description = "Resources for the bundled PostGIS task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "redis_resources" {
  description = "Resources for the bundled Redis task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
