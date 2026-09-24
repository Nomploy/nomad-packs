variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "backrest"
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
  description = "The Backrest container image. Pin a tag in production."
  type        = string
  default     = "garethgeorge/backrest:latest"
}

variable "port" {
  description = "Host port for the Backrest web UI (BACKREST_PORT)."
  type        = number
  default     = 9898
}

variable "data_volume" {
  description = "Named volume for Backrest data (/data): the bundled restic binary and its database."
  type        = string
  default     = "backrest_data"
}

variable "config_volume" {
  description = "Named volume for Backrest config (/config): config.json with your repos and plans."
  type        = string
  default     = "backrest_config"
}

variable "cache_volume" {
  description = "Named volume for the restic cache (/cache)."
  type        = string
  default     = "backrest_cache"
}

variable "sources_volume" {
  description = "Named volume mounted at /userdata to be backed up. Swap for a bind mount to back up real host paths."
  type        = string
  default     = "backrest_sources"
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
  description = "Resources for the Backrest task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
