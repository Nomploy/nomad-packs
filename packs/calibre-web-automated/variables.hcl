variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "calibre-web-automated"
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
  description = "The Calibre-Web Automated container image. Pin a tag in production."
  type        = string
  default     = "crocodilestick/calibre-web-automated:latest"
}

variable "port" {
  description = "Host port for the Calibre-Web Automated web UI."
  type        = number
  default     = 8083
}

variable "data_volume" {
  description = "Named volume mounted at /config (settings + app database)."
  type        = string
  default     = "calibre_web_automated_data"
}

variable "library_volume" {
  description = "Named volume mounted at /calibre-library — the Calibre library. CWA creates one here on first run if empty."
  type        = string
  default     = "calibre_web_automated_library"
}

variable "ingest_volume" {
  description = "Named volume mounted at /cwa-book-ingest — drop ebooks here to auto-import and convert."
  type        = string
  default     = "calibre_web_automated_ingest"
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
