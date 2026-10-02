variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "romm"
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
  description = "The RomM container image. Pin a tag in production."
  type        = string
  default     = "rommapp/romm:latest"
}

variable "mariadb_image" {
  description = "The MariaDB image for the bundled database."
  type        = string
  default     = "mariadb:11"
}

variable "port" {
  description = "Host port for the RomM web UI."
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Host port for the bundled MariaDB (loopback only)."
  type        = number
  default     = 3306
}

variable "db_password" {
  description = "Password for the RomM MariaDB user. CHANGE THIS."
  type        = string
  default     = "romm_change_me"
}

variable "db_root_password" {
  description = "Root password for the bundled MariaDB. CHANGE THIS."
  type        = string
  default     = "romm_root_change_me"
}

variable "auth_secret_key" {
  description = "Secret used to sign sessions (openssl rand -hex 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "0000000000000000000000000000000000000000000000000000000000000000"
}

variable "igdb_client_id" {
  description = "IGDB (Twitch) client ID for metadata scraping. Optional — leave blank to configure later."
  type        = string
  default     = ""
}

variable "igdb_client_secret" {
  description = "IGDB (Twitch) client secret for metadata scraping. Optional — leave blank to configure later."
  type        = string
  default     = ""
}

variable "library_volume" {
  description = "Named volume for the ROM library. Point this at a host path with your ROMs for real use (e.g. a bind mount)."
  type        = string
  default     = "romm_library"
}

variable "resources_volume" {
  description = "Named volume for RomM resources (artwork, metadata)."
  type        = string
  default     = "romm_resources"
}

variable "assets_volume" {
  description = "Named volume for RomM user assets (saves, states, screenshots)."
  type        = string
  default     = "romm_assets"
}

variable "config_volume" {
  description = "Named volume for RomM config."
  type        = string
  default     = "romm_config"
}

variable "redis_volume" {
  description = "Named volume for the bundled Redis data."
  type        = string
  default     = "romm_redis_data"
}

variable "db_data_volume" {
  description = "Named volume for MariaDB data."
  type        = string
  default     = "romm_db_data"
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
  description = "Resources for the RomM app task."
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
  description = "Resources for the bundled MariaDB task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
