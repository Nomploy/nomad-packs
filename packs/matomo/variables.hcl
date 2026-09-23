variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "matomo"
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
  description = "The Matomo container image. Pin a tag in production."
  type        = string
  default     = "matomo:latest"
}

variable "mariadb_image" {
  description = "The MariaDB image for the bundled database."
  type        = string
  default     = "mariadb:11"
}

variable "port" {
  description = "Host port for the Matomo web UI. The app's Apache listens on 80; keep this at 80 or front with a reverse proxy."
  type        = number
  default     = 80
}

variable "db_password" {
  description = "Password for the Matomo database user."
  type        = string
  default     = "matomo"
}

variable "uid" {
  description = "UID the app runs as (www-data). The app volume is chown'd to this at startup."
  type        = number
  default     = 33
}

variable "data_volume" {
  description = "Named volume for the Matomo application files and config (/var/www/html)."
  type        = string
  default     = "matomo_data"
}

variable "db_data_volume" {
  description = "Named volume for MariaDB data (/var/lib/mysql). Holds all your analytics data."
  type        = string
  default     = "matomo_db_data"
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
  description = "Resources for the Matomo app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "mariadb_resources" {
  description = "Resources for the MariaDB task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 512
  }
}
