variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "duplicati"
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
  description = "The Duplicati container image. Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/duplicati:latest"
}

variable "port" {
  description = "Host port for the Duplicati web UI."
  type        = number
  default     = 8210
}

variable "puid" {
  description = "User ID the app runs as (PUID)."
  type        = number
  default     = 1000
}

variable "pgid" {
  description = "Group ID the app runs as (PGID)."
  type        = number
  default     = 1000
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
}

variable "settings_encryption_key" {
  description = "Key that encrypts Duplicati's own settings database (SETTINGS_ENCRYPTION_KEY). CHANGE THIS and keep it stable."
  type        = string
  default     = "change-me-to-a-random-key"
}

variable "config_volume" {
  description = "Named volume for Duplicati config (/config): jobs, schedules, and its settings database."
  type        = string
  default     = "duplicati_config"
}

variable "source_volume" {
  description = "Named volume mounted read data from at /source (what you back up). Swap for a bind mount to back up real host paths."
  type        = string
  default     = "duplicati_source"
}

variable "backups_volume" {
  description = "Named volume for local backup destinations (/backups). Not needed if you back up to cloud storage."
  type        = string
  default     = "duplicati_backups"
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
  description = "Resources for the Duplicati task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
