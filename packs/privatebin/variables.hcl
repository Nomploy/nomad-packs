variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "privatebin"
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
  description = "The PrivateBin all-in-one (nginx + php-fpm) image. Pin a tag in production."
  type        = string
  default     = "privatebin/nginx-fpm-alpine:stable"
}

variable "port" {
  description = "Host port for the PrivateBin web UI."
  type        = number
  default     = 8080
}

variable "data_volume" {
  description = "Named volume for file-based paste storage (/srv/data)."
  type        = string
  default     = "privatebin_data"
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
