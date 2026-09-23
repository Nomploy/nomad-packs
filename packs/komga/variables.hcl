variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "komga"
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
  description = "The Komga container image. Pin a tag in production."
  type        = string
  default     = "gotson/komga:latest"
}

variable "port" {
  description = "Host port for the Komga web UI (SERVER_PORT)."
  type        = number
  default     = 25600
}

variable "config_volume" {
  description = "Named volume for Komga config, the SQLite database, and thumbnails (/config)."
  type        = string
  default     = "komga_config"
}

variable "library_volume" {
  description = "Named volume for your comics/manga/ebook library (/data). Fill it with your files."
  type        = string
  default     = "komga_library"
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
  description = "The task resources (JVM)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
