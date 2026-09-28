variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "centrifugo"
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
  description = "The Centrifugo container image. Pin a tag in production."
  type        = string
  default     = "centrifugo/centrifugo:v6"
}

variable "port" {
  description = "Host port for Centrifugo (HTTP + admin UI)."
  type        = number
  default     = 8000
}

variable "admin_password" {
  description = "Password for the admin web UI. CHANGE THIS."
  type        = string
  default     = "centrifugo_change_me"
}

variable "admin_secret" {
  description = "Secret used to sign admin sessions. CHANGE THIS."
  type        = string
  default     = "change_me_admin_secret_0000000000"
}

variable "api_key" {
  description = "Key for the HTTP server API. CHANGE THIS."
  type        = string
  default     = "change_me_api_key_0000000000"
}

variable "token_hmac_secret" {
  description = "HMAC secret used to verify client connection tokens (JWT). CHANGE THIS."
  type        = string
  default     = "change_me_token_hmac_secret_0000000000"
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
    cpu    = 500
    memory = 256
  }
}
