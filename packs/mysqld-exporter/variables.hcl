variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "mysqld-exporter"
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
  description = "The Prometheus MySQLd Exporter image. Pin a tag in production."
  type        = string
  default     = "prom/mysqld-exporter:latest"
}

variable "port" {
  description = "Host port for the exporter (/metrics)."
  type        = number
  default     = 9104
}

variable "mysql_address" {
  description = "host:port of the MySQL/MariaDB server to scrape (--mysqld.address). With host networking a co-located mariadb pack is reachable on 127.0.0.1:3306."
  type        = string
  default     = "127.0.0.1:3306"
}

variable "mysql_user" {
  description = "MySQL user for the exporter (--mysqld.username). Use a dedicated least-privilege monitoring user in production."
  type        = string
  default     = "exporter"
}

variable "mysql_password" {
  description = "Password for the exporter user (MYSQLD_EXPORTER_PASSWORD)."
  type        = string
  default     = "exporter"
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
    cpu    = 200
    memory = 64
  }
}
