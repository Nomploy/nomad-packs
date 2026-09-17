variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "postgres"
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
  description = "The PostgreSQL container image."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port Postgres listens on (host networking, so it's reachable at <node-ip>:<port>). Pick a free port on the target node."
  type        = number
  default     = 5432
}

variable "count" {
  description = "Number of instances (keep at 1 — local-disk storage, no built-in replication)."
  type        = number
  default     = 1
}

variable "db_name" {
  description = "Initial database created on first boot."
  type        = string
  default     = "app"
}

variable "db_user" {
  description = "Superuser role created on first boot."
  type        = string
  default     = "app"
}

variable "db_password" {
  description = "Password for db_user. CHANGE THIS — it is baked into the job env. Consider a Nomad variable / Vault instead of a default."
  type        = string
  default     = "postgres"
}

variable "data_volume" {
  description = "Docker named volume for the data dir, so the database survives restarts and reschedules (persistent, unlike an alloc-relative bind). A fresh volume inherits the image's data-dir ownership, so Postgres can write it."
  type        = string
  default     = "postgres_data"
}

variable "constraints" {
  description = "Placement constraints — e.g. pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
