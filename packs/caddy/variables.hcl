variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "caddy"
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
  description = "The Caddy container image. Pin a tag in production."
  type        = string
  default     = "caddy:2"
}

variable "http_port" {
  description = "Host port for HTTP."
  type        = number
  default     = 80
}

variable "https_port" {
  description = "Host port for HTTPS (automatic TLS when you use a domain in the Caddyfile)."
  type        = number
  default     = 443
}

variable "caddyfile" {
  description = "The full Caddyfile. The default responds on http_port; replace it to serve files (`root * /srv` + `file_server`) or reverse-proxy (`reverse_proxy 127.0.0.1:PORT`). For automatic HTTPS, use a real domain as the site address."
  type        = string
  default     = <<-EOT
    :80 {
      respond "Caddy is running on nomploy — edit the caddyfile variable to add sites."
    }
  EOT
}

variable "data_volume" {
  description = "Named volume for Caddy's data — ACME certificates and state (/data)."
  type        = string
  default     = "caddy_data"
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
