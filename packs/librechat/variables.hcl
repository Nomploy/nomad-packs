variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "librechat"
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
  description = "The LibreChat container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/danny-avila/librechat:latest"
}

variable "mongo_image" {
  description = "The MongoDB image for the bundled database (needs a CPU with AVX for 5.0+)."
  type        = string
  default     = "mongo:7.0"
}

variable "port" {
  description = "Host port for the LibreChat web UI."
  type        = number
  default     = 3080
}

variable "mongo_port" {
  description = "Host port for the bundled MongoDB."
  type        = number
  default     = 27017
}

variable "creds_key" {
  description = "32-byte (64 hex chars) key for encrypting stored credentials. CHANGE THIS."
  type        = string
  default     = "0000000000000000000000000000000000000000000000000000000000000000"
}

variable "creds_iv" {
  description = "16-byte (32 hex chars) IV for encrypting stored credentials. CHANGE THIS."
  type        = string
  default     = "00000000000000000000000000000000"
}

variable "jwt_secret" {
  description = "Secret for signing JWT access tokens. CHANGE THIS."
  type        = string
  default     = "change_me_jwt_secret_to_a_long_random_value_0000"
}

variable "jwt_refresh_secret" {
  description = "Secret for signing JWT refresh tokens. CHANGE THIS."
  type        = string
  default     = "change_me_jwt_refresh_secret_to_a_long_random_value_0000"
}

variable "allow_registration" {
  description = "Allow new users to register (true/false)."
  type        = string
  default     = "true"
}

variable "data_volume" {
  description = "Named volume for LibreChat app data (/app/data)."
  type        = string
  default     = "librechat_data"
}

variable "uploads_volume" {
  description = "Named volume for uploaded files (/app/uploads)."
  type        = string
  default     = "librechat_uploads"
}

variable "images_volume" {
  description = "Named volume for generated images (/app/client/public/images)."
  type        = string
  default     = "librechat_images"
}

variable "logs_volume" {
  description = "Named volume for API logs (/app/api/logs)."
  type        = string
  default     = "librechat_logs"
}

variable "mongo_data_volume" {
  description = "Named volume for MongoDB data."
  type        = string
  default     = "librechat_mongo_data"
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
  description = "Resources for the LibreChat app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
  }
}

variable "mongo_resources" {
  description = "Resources for the bundled MongoDB task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 1024
  }
}
