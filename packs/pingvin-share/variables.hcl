variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "pingvin-share"
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
  description = "The Pingvin Share container image. Pin a tag in production."
  type        = string
  default     = "stonith404/pingvin-share:latest"
}

variable "port" {
  description = "Host port for the Pingvin Share web UI. The container listens on 3000."
  type        = number
  default     = 3000
}

variable "data_volume" {
  description = "Named volume for Pingvin Share data (/opt/app/backend/data): the SQLite database and uploaded files."
  type        = string
  default     = "pingvin_data"
}

variable "images_volume" {
  description = "Named volume for customization images (/opt/app/frontend/public/img: logo, favicon)."
  type        = string
  default     = "pingvin_images"
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
  description = "Resources for the Pingvin Share task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
