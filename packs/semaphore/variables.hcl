variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "semaphore"
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
  description = "The Semaphore UI container image. Pin a tag in production."
  type        = string
  default     = "semaphoreui/semaphore:latest"
}

variable "port" {
  description = "Host port for the Semaphore web UI. The container listens on 3000."
  type        = number
  default     = 3000
}

variable "admin_user" {
  description = "Initial admin username (SEMAPHORE_ADMIN)."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Initial admin password (SEMAPHORE_ADMIN_PASSWORD). CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "admin_name" {
  description = "Initial admin display name (SEMAPHORE_ADMIN_NAME)."
  type        = string
  default     = "Admin"
}

variable "admin_email" {
  description = "Initial admin email (SEMAPHORE_ADMIN_EMAIL)."
  type        = string
  default     = "admin@nomploy.local"
}

variable "access_key_encryption" {
  description = "Base64 key used to encrypt stored access keys/secrets (SEMAPHORE_ACCESS_KEY_ENCRYPTION). CHANGE THIS and keep it stable. Generate with: head -c32 /dev/urandom | base64."
  type        = string
  default     = "change-me-base64-32-byte-key"
}

variable "data_volume" {
  description = "Named volume for Semaphore data (/var/lib/semaphore): the BoltDB database and repositories."
  type        = string
  default     = "semaphore_data"
}

variable "config_volume" {
  description = "Named volume for Semaphore config (/etc/semaphore)."
  type        = string
  default     = "semaphore_config"
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
  description = "Resources for the Semaphore task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
