variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "homepage"
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
  description = "The Homepage container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/gethomepage/homepage:latest"
}

variable "port" {
  description = "Host port for the dashboard. Default 3006 to avoid the panel (3000), grafana (3001), gitea (3002), metabase (3003), umami (3005)."
  type        = number
  default     = 3006
}

variable "allowed_hosts" {
  description = "REQUIRED by recent Homepage for security: comma-separated Host header values it will serve (e.g. \"home.example.com\" or \"<node-ip>:3006\"). If wrong/unset you'll get a \"host validation\" error page."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /app/config (settings.yaml, services.yaml, bookmarks.yaml, widgets.yaml). Homepage seeds defaults here on first run. Runs as root, so a fresh volume is writable."
  type        = string
  default     = "homepage_config"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
