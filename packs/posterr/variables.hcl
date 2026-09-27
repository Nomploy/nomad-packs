variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "posterr"
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
  description = "The Posterr container image. Pin a tag in production."
  type        = string
  default     = "petersem/posterr:latest"
}

variable "port" {
  description = "Host port for the Posterr web UI."
  type        = number
  default     = 3000
}

variable "data_volume" {
  description = "Named volume mounted at /usr/src/app/config (settings)."
  type        = string
  default     = "posterr_data"
}

variable "custom_volume" {
  description = "Named volume mounted at /usr/src/app/public/custom — custom images/media to display."
  type        = string
  default     = "posterr_custom"
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
