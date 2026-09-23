variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "pocket-id"
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
  description = "The Pocket ID container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/pocket-id/pocket-id:latest"
}

variable "port" {
  description = "Host port for the Pocket ID web UI / OIDC endpoints (PORT)."
  type        = number
  default     = 1411
}

variable "app_url" {
  description = "Public URL Pocket ID is served at (APP_URL). REQUIRED for passkeys — WebAuthn is origin-bound, so this must be the exact scheme+host+port your browser uses. Empty = http://localhost:<port> (dev only)."
  type        = string
  default     = ""
}

variable "trust_proxy" {
  description = "Trust reverse-proxy headers for the real client IP (TRUST_PROXY)."
  type        = bool
  default     = false
}

variable "data_volume" {
  description = "Named volume for the SQLite database and keys (/app/data)."
  type        = string
  default     = "pocket_id_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
