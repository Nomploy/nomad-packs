variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "arangodb"
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
  description = "The ArangoDB container image. Pin a tag in production."
  type        = string
  default     = "arangodb/arangodb:3.12.12"
}

variable "port" {
  description = "Host port for the ArangoDB server / web UI."
  type        = number
  default     = 8529
}

variable "root_password" {
  description = "Password for the root user. CHANGE THIS."
  type        = string
  default     = "arangodb_change_me"
}

variable "data_volume" {
  description = "Named volume for database files (/var/lib/arangodb3)."
  type        = string
  default     = "arangodb_data"
}

variable "apps_volume" {
  description = "Named volume for Foxx apps (/var/lib/arangodb3-apps)."
  type        = string
  default     = "arangodb_apps"
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
    cpu    = 1000
    memory = 2048
  }
}
