variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "lms"
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
  description = "The LMS container image. Pin a tag in production."
  type        = string
  default     = "epoupon/lms:latest"
}

variable "port" {
  description = "Host port for the LMS web UI."
  type        = number
  default     = 5082
}

variable "data_volume" {
  description = "Named volume mounted at /var/lms (database, config and caches)."
  type        = string
  default     = "lms_data"
}

variable "music_volume" {
  description = "Named volume mounted at /music (read-only) — your music library."
  type        = string
  default     = "lms_music"
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
