variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "damselfly"
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
  description = "The Damselfly container image. Pin a tag in production."
  type        = string
  default     = "webreaper/damselfly:latest"
}

variable "port" {
  description = "Host port for the Damselfly web UI."
  type        = number
  default     = 6363
}

variable "config_volume" {
  description = "Named volume for the Damselfly database and config (/config)."
  type        = string
  default     = "damselfly_config"
}

variable "thumbs_volume" {
  description = "Named volume for generated thumbnails (/thumbs)."
  type        = string
  default     = "damselfly_thumbs"
}

variable "pictures_volume" {
  description = "Named volume for the photo library root (/pictures)."
  type        = string
  default     = "damselfly_pictures"
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
  description = "The task resources. AI recognition benefits from extra memory."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
  }
}
