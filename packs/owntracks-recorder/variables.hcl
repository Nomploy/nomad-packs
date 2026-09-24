variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "owntracks-recorder"
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
  description = "The OwnTracks Recorder container image. Pin a tag in production."
  type        = string
  default     = "owntracks/recorder:latest"
}

variable "port" {
  description = "Host port for the Recorder web UI / API. The container listens on 8083."
  type        = number
  default     = 8083
}

variable "data_volume" {
  description = "Named volume for recorded location data (/store): the .rec history and last-position store."
  type        = string
  default     = "owntracks_store"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Recorder task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 128
  }
}
