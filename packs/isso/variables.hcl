variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "isso"
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
  description = "The Isso container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/isso-comments/isso:latest"
}

variable "port" {
  description = "Host port for the Isso API."
  type        = number
  default     = 8080
}

variable "host" {
  description = "The website URL(s) where comments are embedded (comma-separated). Isso only accepts comments from these origins — set this to your blog's URL."
  type        = string
  default     = "http://localhost"
}

variable "data_volume" {
  description = "Named volume for the SQLite comments database."
  type        = string
  default     = "isso_data"
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
  description = "Resources for the Isso task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
