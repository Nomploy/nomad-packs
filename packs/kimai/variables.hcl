variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kimai"
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
  description = "The Kimai (Apache) container image. Pin a tag in production."
  type        = string
  default     = "kimai/kimai2:apache-latest"
}

variable "mariadb_image" {
  description = "The MariaDB image for the bundled database."
  type        = string
  default     = "mariadb:11"
}

variable "port" {
  description = "Host port for the Kimai web UI."
  type        = number
  default     = 8001
}

variable "db_port" {
  description = "Host port for the co-located MariaDB."
  type        = number
  default     = 3306
}

variable "db_password" {
  description = "Password for the Kimai database user."
  type        = string
  default     = "kimai"
}

variable "admin_email" {
  description = "Initial super-admin email (ADMINMAIL)."
  type        = string
  default     = "admin@nomploy.local"
}

variable "admin_password" {
  description = "Initial super-admin password (ADMINPASS, min 8 chars). CHANGE THIS."
  type        = string
  default     = "changeme-please"
}

variable "trusted_hosts" {
  description = "Hosts Kimai will answer for (TRUSTED_HOSTS). Include the node IP/domain you access it on."
  type        = string
  default     = "localhost,127.0.0.1"
}

variable "uid" {
  description = "UID the app runs as (www-data). The data volume is chown'd to this at startup."
  type        = number
  default     = 33
}

variable "data_volume" {
  description = "Named volume for Kimai runtime data — invoices, uploads (/opt/kimai/var/data)."
  type        = string
  default     = "kimai_data"
}

variable "db_data_volume" {
  description = "Named volume for MariaDB data (/var/lib/mysql). Holds all time records."
  type        = string
  default     = "kimai_db_data"
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
  description = "Resources for the Kimai app task."
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
