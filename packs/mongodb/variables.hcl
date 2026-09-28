variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "mongodb"
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
  description = "The MongoDB container image (5.0+ needs a CPU with AVX). Pin a tag in production."
  type        = string
  default     = "mongo:7.0"
}

variable "port" {
  description = "Host port for MongoDB."
  type        = number
  default     = 27017
}

variable "root_username" {
  description = "Root username created on first start."
  type        = string
  default     = "root"
}

variable "root_password" {
  description = "Root password created on first start. CHANGE THIS."
  type        = string
  default     = "mongodb_change_me"
}

variable "data_volume" {
  description = "Named volume for MongoDB data (/data/db)."
  type        = string
  default     = "mongodb_data"
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
    cpu    = 500
    memory = 1024
  }
}
