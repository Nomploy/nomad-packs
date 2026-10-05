variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "blocky"
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
  description = "The Blocky container image. Pin a tag in production."
  type        = string
  default     = "spx01/blocky:latest"
}

variable "dns_port" {
  description = "Host port for DNS (UDP + TCP). Point your network's DNS at this."
  type        = number
  default     = 53
}

variable "http_port" {
  description = "Host port for the HTTP API / Prometheus metrics / query UI."
  type        = number
  default     = 4000
}

variable "upstreams" {
  description = "Upstream DNS resolvers for the default group (DoH/DoT/plain)."
  type        = list(string)
  default     = ["https://dns.quad9.net/dns-query", "https://cloudflare-dns.com/dns-query"]
}

variable "blocklists" {
  description = "Blocklist (denylist) URLs applied to all clients."
  type        = list(string)
  default     = ["https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"]
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
  description = "Resources for the Blocky task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
