variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "wekan"
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
  description = "The WeKan container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/wekan/wekan:latest"
}

variable "mongo_image" {
  description = "The MongoDB image for the bundled database (needs a CPU with AVX for 5.0+)."
  type        = string
  default     = "mongo:7.0"
}

variable "port" {
  description = "Host port for the WeKan web UI."
  type        = number
  default     = 8080
}

variable "mongo_port" {
  description = "Host port for the bundled MongoDB."
  type        = number
  default     = 27017
}

variable "root_url" {
  description = "Public URL WeKan is served from (used in links/emails). Set to your address."
  type        = string
  default     = "http://localhost:8080"
}

variable "data_volume" {
  description = "Named volume for WeKan uploads/attachments (/data)."
  type        = string
  default     = "wekan_data"
}

variable "mongo_data_volume" {
  description = "Named volume for MongoDB data."
  type        = string
  default     = "wekan_mongo_data"
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
  description = "Resources for the WeKan app task (Meteor/Node is memory-hungry)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1536
  }
}

variable "mongo_resources" {
  description = "Resources for the bundled MongoDB task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
