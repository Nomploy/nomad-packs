variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kapowarr"
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
  description = "The Kapowarr container image. Pin a tag in production."
  type        = string
  default     = "mrcas/kapowarr:latest"
}

variable "port" {
  description = "Host port for the Kapowarr web UI."
  type        = number
  default     = 5656
}

variable "data_volume" {
  description = "Named volume mounted at /app/db (the SQLite database)."
  type        = string
  default     = "kapowarr_data"
}

variable "downloads_volume" {
  description = "Named volume mounted at /app/temp_downloads — in-progress downloads."
  type        = string
  default     = "kapowarr_downloads"
}

variable "comics_volume" {
  description = "Named volume mounted at /comics — your managed comic library (root folder)."
  type        = string
  default     = "kapowarr_comics"
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
