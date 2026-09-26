variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "deluge"
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
  description = "The Deluge container image. Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/deluge:latest"
}

variable "port" {
  description = "Host port for the Deluge web UI."
  type        = number
  default     = 8112
}

variable "peer_port" {
  description = "BitTorrent peer port (TCP + UDP). Forward this on your router/firewall."
  type        = number
  default     = 6881
}

variable "daemon_port" {
  description = "Deluge daemon port for thin-client (deluged RPC) connections."
  type        = number
  default     = 58846
}

variable "data_volume" {
  description = "Named volume mounted at /config (settings and state)."
  type        = string
  default     = "deluge_data"
}

variable "downloads_volume" {
  description = "Named volume mounted at /downloads — your downloads."
  type        = string
  default     = "deluge_downloads"
}

variable "puid" {
  description = "User ID that owns the files (PUID)."
  type        = number
  default     = 1000
}

variable "pgid" {
  description = "Group ID that owns the files (PGID)."
  type        = number
  default     = 1000
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
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
