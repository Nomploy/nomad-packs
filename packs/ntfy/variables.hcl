variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ntfy"
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
  description = "The ntfy container image. Pin a tag in production."
  type        = string
  default     = "binwiederhier/ntfy:latest"
}

variable "port" {
  description = "Host port for the ntfy HTTP server (web app + API)."
  type        = number
  default     = 8090
}

variable "base_url" {
  description = "Public base URL ntfy is served at (e.g. https://ntfy.example.com). Recommended — the web app and mobile clients use it. Empty = leave unset."
  type        = string
  default     = ""
}

variable "behind_proxy" {
  description = "Set true when running behind a reverse proxy (enables correct client IP handling for rate limits)."
  type        = bool
  default     = false
}

variable "data_volume" {
  description = "Docker named volume for /var/lib/ntfy (message cache, user/auth database, attachments). ntfy runs as root, so a fresh volume is writable."
  type        = string
  default     = "ntfy_data"
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
    cpu    = 200
    memory = 128
  }
}
