variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "automatisch"
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
  description = "The Automatisch container image (used for both web and worker). Pin a tag in production."
  type        = string
  default     = "automatischio/automatisch:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16"
}

variable "redis_image" {
  description = "The Redis image for the bundled queue."
  type        = string
  default     = "redis:7"
}

variable "port" {
  description = "Host port for the Automatisch web UI / API."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL (loopback only)."
  type        = number
  default     = 5432
}

variable "redis_port" {
  description = "Host port for the bundled Redis (loopback only)."
  type        = number
  default     = 6379
}

variable "host" {
  description = "Public hostname of this Automatisch instance (used to build links and webhook URLs)."
  type        = string
  default     = "localhost"
}

variable "protocol" {
  description = "Public protocol (http or https) used to build links and webhook URLs."
  type        = string
  default     = "http"
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "automatisch_change_me"
}

variable "encryption_key" {
  description = "Key used to encrypt stored connection credentials (openssl rand -base64 36). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_encryption_key_to_a_long_random_value"
}

variable "webhook_secret_key" {
  description = "Secret used to sign webhook URLs (openssl rand -base64 36). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_webhook_secret_to_a_long_random_value"
}

variable "app_secret_key" {
  description = "Secret used to sign sessions/tokens (openssl rand -base64 36). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_app_secret_to_a_long_random_value"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "automatisch_db_data"
}

variable "storage_volume" {
  description = "Named volume for uploaded files, shared by web and worker."
  type        = string
  default     = "automatisch_storage"
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
  description = "Resources for the Automatisch web task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "worker_resources" {
  description = "Resources for the Automatisch worker task."
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
