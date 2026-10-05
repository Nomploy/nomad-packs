variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "babybuddy"
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
  description = "The Baby Buddy container image (LinuxServer). Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/babybuddy:latest"
}

variable "port" {
  description = "Host port for the Baby Buddy web UI."
  type        = number
  default     = 8000
}

variable "csrf_trusted_origins" {
  description = "Comma-separated origins allowed to submit forms. Include your public URL (e.g. https://babybuddy.example.com)."
  type        = string
  default     = "http://localhost:8000"
}

variable "timezone" {
  description = "Container timezone."
  type        = string
  default     = "UTC"
}

variable "puid" {
  description = "User ID the container runs as (file ownership on the config volume)."
  type        = number
  default     = 1000
}

variable "pgid" {
  description = "Group ID the container runs as."
  type        = number
  default     = 1000
}

variable "config_volume" {
  description = "Named volume for Baby Buddy config and the SQLite database."
  type        = string
  default     = "babybuddy_config"
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
  description = "Resources for the Baby Buddy task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
