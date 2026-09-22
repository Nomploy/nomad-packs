variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "surrealdb"
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
  description = "The SurrealDB container image. Pin a tag in production."
  type        = string
  default     = "surrealdb/surrealdb:latest"
}

variable "port" {
  description = "Host port for the SurrealDB HTTP/WebSocket API."
  type        = number
  default     = 8000
}

variable "root_user" {
  description = "Initial root username (created on first start, then persisted in storage)."
  type        = string
  default     = "root"
}

variable "root_password" {
  description = "Initial root password. CHANGE THIS."
  type        = string
  default     = "root"
}

variable "data_volume" {
  description = "Docker named volume for /data (the RocksDB storage). SurrealDB runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "surrealdb_data"
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
