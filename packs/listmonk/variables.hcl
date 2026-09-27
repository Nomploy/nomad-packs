variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "listmonk"
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
  description = "The listmonk container image. Pin a tag in production."
  type        = string
  default     = "listmonk/listmonk:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:17-alpine"
}

variable "port" {
  description = "Host port for the listmonk web UI."
  type        = number
  default     = 9000
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "listmonk_change_me"
}

variable "admin_user" {
  description = "Super-admin username created on first start."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Super-admin password created on first start. CHANGE THIS (min 8 chars)."
  type        = string
  default     = "listmonk_admin_change_me"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "listmonk_db_data"
}

variable "uploads_volume" {
  description = "Named volume for uploaded media (/listmonk/uploads)."
  type        = string
  default     = "listmonk_uploads"
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
  description = "Resources for the listmonk app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
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
