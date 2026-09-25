variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "wizarr"
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
  description = "The Wizarr container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/wizarrrr/wizarr:latest"
}

variable "port" {
  description = "Host port for the Wizarr web UI."
  type        = number
  default     = 5690
}

variable "data_volume" {
  description = "Named volume mounted at /data/database (settings and the SQLite database)."
  type        = string
  default     = "wizarr_data"
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
