variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kavita"
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
  description = "The Kavita container image. Pin a tag in production."
  type        = string
  default     = "jvmilazz0/kavita:latest"
}

variable "port" {
  description = "Host port for the Kavita web UI. The container listens on 5000."
  type        = number
  default     = 5000
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
}

variable "config_volume" {
  description = "Named volume for Kavita config (/kavita/config): SQLite database, covers, bookmarks, logs, backups."
  type        = string
  default     = "kavita_config"
}

variable "library_volume" {
  description = "Named volume for your library files (/data): the manga, comics, and books Kavita scans."
  type        = string
  default     = "kavita_library"
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
  description = "Resources for the Kavita task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
