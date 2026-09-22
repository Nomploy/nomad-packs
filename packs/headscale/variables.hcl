variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "headscale"
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
  description = "The Headscale container image. Pin a tag in production (config schema is version-specific)."
  type        = string
  default     = "headscale/headscale:0.23.0"
}

variable "port" {
  description = "Host port for the Headscale HTTP/control endpoint."
  type        = number
  default     = 8080
}

variable "metrics_port" {
  description = "Host port for the Prometheus metrics endpoint."
  type        = number
  default     = 9099
}

variable "server_url" {
  description = "The public URL clients connect to (SERVER_URL). MUST be reachable by your devices, e.g. http://<node-ip>:8080 or https://vpn.example.com. Empty = http://localhost:<port> (dev only)."
  type        = string
  default     = ""
}

variable "base_domain" {
  description = "MagicDNS base domain for the tailnet."
  type        = string
  default     = "headscale.internal"
}

variable "data_volume" {
  description = "Named volume for the SQLite database and generated keys (/var/lib/headscale)."
  type        = string
  default     = "headscale_data"
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
