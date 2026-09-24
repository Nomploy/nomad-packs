variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "slskd"
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
  description = "The slskd container image. Pin a tag in production."
  type        = string
  default     = "slskd/slskd:latest"
}

variable "web_port" {
  description = "Host port for the web UI (SLSKD_HTTP_PORT)."
  type        = number
  default     = 5030
}

variable "listen_port" {
  description = "Host port slskd listens on for incoming Soulseek connections (SLSKD_SLSK_LISTEN_PORT). Forward this if you can, for better peering."
  type        = number
  default     = 50300
}

variable "slsk_username" {
  description = "Your Soulseek network username (SLSKD_SLSK_USERNAME)."
  type        = string
  default     = "change-me"
}

variable "slsk_password" {
  description = "Your Soulseek network password (SLSKD_SLSK_PASSWORD)."
  type        = string
  default     = "change-me"
}

variable "data_volume" {
  description = "Named volume for slskd data (/app): config, database, downloads, and shares."
  type        = string
  default     = "slskd_data"
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
  description = "Resources for the slskd task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
