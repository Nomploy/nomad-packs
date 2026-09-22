variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "rustdesk"
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
  description = "The RustDesk server (s6, hbbs+hbbr) image. Pin a tag in production."
  type        = string
  default     = "rustdesk/rustdesk-server-s6:latest"
}

variable "relay_host" {
  description = "Public IP or hostname clients use to reach the relay (RELAY). Empty = not set (clients fall back to the ID server's address)."
  type        = string
  default     = ""
}

variable "encrypted_only" {
  description = "Reject unencrypted connections (ENCRYPTED_ONLY: 1 = require encryption)."
  type        = number
  default     = 0
}

variable "data_volume" {
  description = "Named volume for the server keys (id_ed25519) and database (/data)."
  type        = string
  default     = "rustdesk_data"
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
    memory = 128
  }
}
