variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "twenty"
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
  description = "The Twenty container image (used for both server and worker). Pin a tag in production."
  type        = string
  default     = "twentycrm/twenty:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16"
}

variable "redis_image" {
  description = "The Redis image for the bundled cache/queue."
  type        = string
  default     = "redis:7-alpine"
}

variable "port" {
  description = "Host port for the Twenty web UI / API."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL."
  type        = number
  default     = 5432
}

variable "redis_port" {
  description = "Host port for the bundled Redis."
  type        = number
  default     = 6379
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "twenty_change_me"
}

variable "app_secret" {
  description = "Secret used to sign tokens (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_app_secret_to_a_long_random_value_00000000"
}

variable "server_url" {
  description = "Public URL of this Twenty instance (used for links and API)."
  type        = string
  default     = "http://localhost:3000"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "twenty_db_data"
}

variable "storage_volume" {
  description = "Named volume for local file storage, shared by server and worker."
  type        = string
  default     = "twenty_storage"
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
  description = "Resources for the Twenty server task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
  }
}

variable "worker_resources" {
  description = "Resources for the Twenty worker task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 1024
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

variable "redis_resources" {
  description = "Resources for the bundled Redis task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
