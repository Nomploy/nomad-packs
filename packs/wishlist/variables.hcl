variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "wishlist"
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
  description = "The Wishlist container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/cmintey/wishlist:latest"
}

variable "port" {
  description = "Host port for the Wishlist web UI."
  type        = number
  default     = 3280
}

variable "data_volume" {
  description = "Named volume mounted at /usr/src/app/data (the SQLite database)."
  type        = string
  default     = "wishlist_data"
}

variable "uploads_volume" {
  description = "Named volume mounted at /usr/src/app/uploads (uploaded item images)."
  type        = string
  default     = "wishlist_uploads"
}

variable "base_url" {
  description = "Public URL users connect to (ORIGIN). MUST match the address you open, including the port, or logins/uploads break. Empty = http://localhost:<port>."
  type        = string
  default     = ""
}

variable "token_time" {
  description = "Hours until login/invite tokens expire (TOKEN_TIME)."
  type        = number
  default     = 72
}

variable "default_currency" {
  description = "ISO 4217 currency code used as the global default (DEFAULT_CURRENCY), e.g. EUR, USD."
  type        = string
  default     = "USD"
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
