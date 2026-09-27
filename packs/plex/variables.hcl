variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "plex"
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
  description = "The Plex container image. Pin a tag in production."
  type        = string
  default     = "plexinc/pms-docker:latest"
}

variable "port" {
  description = "Host port for the Plex web UI."
  type        = number
  default     = 32400
}

variable "data_volume" {
  description = "Named volume mounted at /config (Plex database and settings)."
  type        = string
  default     = "plex_data"
}

variable "media_volume" {
  description = "Named volume mounted at /data — your media library."
  type        = string
  default     = "plex_media"
}

variable "transcode_volume" {
  description = "Named volume mounted at /transcode — temporary transcoder scratch."
  type        = string
  default     = "plex_transcode"
}

variable "claim_token" {
  description = "Optional Plex claim token (PLEX_CLAIM) to link the server to your account on first run — get one at https://plex.tv/claim (valid ~4 min). Leave empty to claim later via the web setup."
  type        = string
  default     = ""
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
