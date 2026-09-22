variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "jellyfin"
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
  description = "The official Jellyfin container image. Pin a tag in production."
  type        = string
  default     = "jellyfin/jellyfin:latest"
}

variable "port" {
  description = "Host port for the Jellyfin web UI (Jellyfin's default HTTP port; to use another you must also change it in Dashboard -> Networking after first run)."
  type        = number
  default     = 8096
}

variable "config_volume" {
  description = "Named volume for Jellyfin config, metadata, and its database (/config)."
  type        = string
  default     = "jellyfin_config"
}

variable "cache_volume" {
  description = "Named volume for transcoding/cache data (/cache)."
  type        = string
  default     = "jellyfin_cache"
}

variable "media_volume" {
  description = "Named volume mounted read-only at /media — fill it with your library."
  type        = string
  default     = "jellyfin_media"
}

variable "published_server_url" {
  description = "Optional public URL clients should use (JELLYFIN_PublishedServerUrl). Empty = auto."
  type        = string
  default     = ""
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources (raise cpu for software transcoding)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 1024
  }
}
