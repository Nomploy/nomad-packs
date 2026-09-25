variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kitchenowl"
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
  description = "The KitchenOwl container image. Pin a tag in production."
  type        = string
  default     = "tombursch/kitchenowl:latest"
}

variable "port" {
  description = "Host port for the KitchenOwl web UI."
  type        = number
  default     = 8080
}

variable "data_volume" {
  description = "Named volume mounted at /data (SQLite database and uploads)."
  type        = string
  default     = "kitchenowl_data"
}

variable "jwt_secret_key" {
  description = "Secret used to sign session tokens (JWT_SECRET_KEY). CHANGE THIS and keep it STABLE. Generate with: openssl rand -base64 36."
  type        = string
  default     = "change-me-openssl-rand-base64-36"
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
    cpu    = 300
    memory = 256
  }
}
