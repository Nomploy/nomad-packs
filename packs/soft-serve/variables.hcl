variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "soft-serve"
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
  description = "The Soft Serve container image. Pin a tag in production."
  type        = string
  default     = "charmcli/soft-serve:latest"
}

variable "port" {
  description = "SSH port — the primary interface (browse repos via the TUI, push over SSH)."
  type        = number
  default     = 23231
}

variable "http_port" {
  description = "HTTP port for read-only web browsing and git-over-HTTP clone."
  type        = number
  default     = 23232
}

variable "git_port" {
  description = "Git daemon port (anonymous git:// protocol)."
  type        = number
  default     = 9418
}

variable "stats_port" {
  description = "Prometheus stats/metrics port."
  type        = number
  default     = 23233
}

variable "admin_keys" {
  description = "SSH public key(s) granted admin, space/newline-separated (SOFT_SERVE_INITIAL_ADMIN_KEYS). SET THIS to your key, e.g. \"ssh-ed25519 AAAA... you@host\", or you can't administer the server."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume mounted at /soft-serve — repositories, config and host keys."
  type        = string
  default     = "soft_serve_data"
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
    cpu    = 300
    memory = 256
  }
}
