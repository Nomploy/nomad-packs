variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "cloudflare-ddns"
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
  description = "The favonia/cloudflare-ddns container image. Pin a tag in production."
  type        = string
  default     = "favonia/cloudflare-ddns:1"
}

variable "api_token" {
  description = "Cloudflare API token with DNS edit permission (CLOUDFLARE_API_TOKEN). REQUIRED."
  type        = string
  default     = "your-cloudflare-api-token"
}

variable "domains" {
  description = "Comma-separated domains/records to keep updated (DOMAINS), e.g. home.example.com,vpn.example.com. REQUIRED."
  type        = string
  default     = "home.example.com"
}

variable "proxied" {
  description = "Whether the records should be Cloudflare-proxied (PROXIED)."
  type        = bool
  default     = false
}

variable "ip6_provider" {
  description = "IPv6 detection (IP6_PROVIDER). Set \"none\" to disable IPv6 updates if you have no IPv6."
  type        = string
  default     = "none"
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
    cpu    = 100
    memory = 64
  }
}
