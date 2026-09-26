variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "hoodik"
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
  description = "The Hoodik container image. Pin a tag in production."
  type        = string
  default     = "hudik/hoodik:latest"
}

variable "port" {
  description = "Host port for the Hoodik web UI (HTTPS)."
  type        = number
  default     = 5443
}

variable "data_volume" {
  description = "Named volume mounted at /data (SQLite database, uploaded files, and the self-signed TLS cert)."
  type        = string
  default     = "hoodik_data"
}

variable "base_url" {
  description = "Public URL Hoodik is reachable at (APP_URL). Required — must be the exact URL users open. Empty = https://localhost:<port>."
  type        = string
  default     = ""
}

variable "jwt_secret" {
  description = "Secret used to sign session tokens (JWT_SECRET). CHANGE THIS and keep it STABLE (changing it logs everyone out). Generate with: openssl rand -base64 36."
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
