variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "firefly-iii"
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
  description = "The Firefly III container image. Pin a tag in production."
  type        = string
  default     = "fireflyiii/core:latest"
}

variable "mariadb_image" {
  description = "The MariaDB image for the bundled database."
  type        = string
  default     = "mariadb:11"
}

variable "port" {
  description = "Host port for the Firefly III web UI. The app's Apache listens on 8080; there is no env to change it, so keep this at 8080 (front with a reverse proxy for another port)."
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Host port for the co-located MariaDB."
  type        = number
  default     = 3306
}

variable "db_password" {
  description = "Password for the Firefly III database user."
  type        = string
  default     = "firefly"
}

variable "app_key" {
  description = "Laravel APP_KEY — must be EXACTLY 32 characters. Generate a random one. CHANGE THIS."
  type        = string
  default     = "0123456789abcdef0123456789abcdef"
}

variable "app_url" {
  description = "Public URL Firefly III is served at (APP_URL). Empty = http://localhost:<port>."
  type        = string
  default     = ""
}

variable "uid" {
  description = "UID the app runs as (www-data). The upload volume is chown'd to this at startup."
  type        = number
  default     = 33
}

variable "upload_volume" {
  description = "Named volume for uploaded attachments (/var/www/html/storage/upload)."
  type        = string
  default     = "firefly_upload"
}

variable "db_data_volume" {
  description = "Named volume for MariaDB data (/var/lib/mysql). Holds all your financial data."
  type        = string
  default     = "firefly_db_data"
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
  description = "Resources for the Firefly III app task."
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
