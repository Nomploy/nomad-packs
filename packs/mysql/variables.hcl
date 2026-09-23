variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "mysql"
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
  description = "The MySQL container image. Pin a tag in production."
  type        = string
  default     = "mysql:8"
}

variable "port" {
  description = "Host port MySQL listens on."
  type        = number
  default     = 3306
}

variable "database" {
  description = "Initial database created on first start (MYSQL_DATABASE)."
  type        = string
  default     = "app"
}

variable "username" {
  description = "Application user created on first start (MYSQL_USER)."
  type        = string
  default     = "app"
}

variable "password" {
  description = "Password for the application user (MYSQL_PASSWORD). CHANGE THIS."
  type        = string
  default     = "mysql"
}

variable "root_password" {
  description = "Password for the MySQL root user (MYSQL_ROOT_PASSWORD). CHANGE THIS."
  type        = string
  default     = "mysql"
}

variable "data_volume" {
  description = "Named volume for the database (/var/lib/mysql)."
  type        = string
  default     = "mysql_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
