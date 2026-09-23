variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "searxng"
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
  description = "The SearXNG container image. Pin a tag in production."
  type        = string
  default     = "searxng/searxng:latest"
}

variable "port" {
  description = "Host port for the SearXNG web UI. The container listens on 8080; keep this at 8080 unless you also change server.port in the settings volume."
  type        = number
  default     = 8080
}

variable "base_url" {
  description = "Public base URL SearXNG is served at (SEARXNG_BASE_URL), e.g. https://search.example.com/. Empty = http://localhost:<port>/."
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "Secret used to sign the search UI (SEARXNG_SECRET). CHANGE THIS — generate with: openssl rand -hex 32."
  type        = string
  default     = "change-me-to-a-random-secret"
}

variable "data_volume" {
  description = "Named volume for SearXNG settings and config (/etc/searxng, holds settings.yml)."
  type        = string
  default     = "searxng_data"
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
  description = "Resources for the SearXNG task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
