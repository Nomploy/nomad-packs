variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "wg-easy"
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
  description = "The wg-easy container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/wg-easy/wg-easy:14"
}

variable "wg_host" {
  description = "Public IP or hostname clients connect to (WG_HOST). SET THIS to your server's public address."
  type        = string
  default     = "vpn.example.com"
}

variable "password" {
  description = "Password for the web UI (PASSWORD). CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "web_port" {
  description = "Host port for the web UI (PORT)."
  type        = number
  default     = 51821
}

variable "wg_port" {
  description = "Host UDP port for WireGuard traffic (WG_PORT). Must be reachable from the internet."
  type        = number
  default     = 51820
}

variable "data_volume" {
  description = "Named volume for WireGuard config (/etc/wireguard): keys and client definitions."
  type        = string
  default     = "wg_easy_data"
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
  description = "Resources for the wg-easy task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 128
  }
}
