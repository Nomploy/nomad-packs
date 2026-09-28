variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ackee"
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
  description = "The Ackee container image. Pin a tag in production."
  type        = string
  default     = "electerious/ackee:latest"
}

variable "mongo_image" {
  description = "The MongoDB image for the bundled database (5.0+ needs a CPU with AVX)."
  type        = string
  default     = "mongo:7.0"
}

variable "port" {
  description = "Host port for the Ackee web UI / API."
  type        = number
  default     = 3000
}

variable "mongo_port" {
  description = "Host port for the bundled MongoDB."
  type        = number
  default     = 27017
}

variable "admin_username" {
  description = "Ackee admin username."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Ackee admin password. CHANGE THIS."
  type        = string
  default     = "ackee_change_me"
}

variable "mongo_data_volume" {
  description = "Named volume for MongoDB data."
  type        = string
  default     = "ackee_mongo_data"
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
  description = "Resources for the Ackee app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
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
