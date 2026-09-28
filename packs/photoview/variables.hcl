variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "photoview"
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
  description = "The Photoview container image. Pin a tag in production."
  type        = string
  default     = "photoview/photoview:latest"
}

variable "port" {
  description = "Host port for the Photoview web UI."
  type        = number
  default     = 8000
}

variable "data_volume" {
  description = "Named volume for the SQLite database and generated media cache (/app/data)."
  type        = string
  default     = "photoview_data"
}

variable "media_volume" {
  description = "Named volume for your photo library (/photos)."
  type        = string
  default     = "photoview_media"
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
  description = "The task resources. Face recognition and thumbnailing benefit from more CPU/memory."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
