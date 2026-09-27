variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "snipe-it"
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
  description = "The Snipe-IT container image. Pin a tag in production."
  type        = string
  default     = "snipe/snipe-it:latest"
}

variable "port" {
  description = "Host port for the Snipe-IT web UI."
  type        = number
  default     = 8000
}

variable "app_key" {
  description = "Laravel APP_KEY. MUST be 'base64:' + a base64-encoded 32-byte value, and CHANGE THIS (it encrypts data). Generate: echo \"base64:$(openssl rand -base64 32)\"."
  type        = string
  default     = "base64:0000000000000000000000000000000000000000000="
}

variable "base_url" {
  description = "Public URL Snipe-IT is reached at (APP_URL). Empty = http://localhost:<port>. Set to your real host/domain."
  type        = string
  default     = ""
}

variable "mariadb_image" {
  description = "The MariaDB image for the bundled database."
  type        = string
  default     = "mariadb:11"
}

variable "db_port" {
  description = "Host port for the bundled MariaDB (loopback only)."
  type        = number
  default     = 3306
}

variable "db_password" {
  description = "Password for the Snipe-IT database user. CHANGE THIS."
  type        = string
  default     = "change-me-snipeit-db"
}

variable "data_volume" {
  description = "Named volume mounted at /var/lib/snipeit (uploads and app data)."
  type        = string
  default     = "snipe_it_data"
}

variable "db_data_volume" {
  description = "Named volume for the MariaDB data directory."
  type        = string
  default     = "snipe_it_db"
}

variable "db_resources" {
  description = "Resources for the MariaDB task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 400
    memory = 512
  }
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
