variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "timescaledb"
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
  description = "The TimescaleDB container image (PostgreSQL + TimescaleDB extension). Pin a tag in production."
  type        = string
  default     = "timescale/timescaledb:latest-pg16"
}

variable "port" {
  description = "Host port the database listens on (host networking). Pick a free port on the target node."
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Initial database created on first boot (the timescaledb extension is available in it)."
  type        = string
  default     = "app"
}

variable "db_user" {
  description = "Superuser role created on first boot."
  type        = string
  default     = "app"
}

variable "db_password" {
  description = "Password for db_user. CHANGE THIS — it is baked into the job env."
  type        = string
  default     = "timescale"
}

variable "data_volume" {
  description = "Docker named volume for the data dir. A fresh volume inherits the image's data-dir ownership (uid 999), so Postgres can write it. Back it up."
  type        = string
  default     = "timescaledb_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
