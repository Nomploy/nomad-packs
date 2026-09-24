variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "filestash"
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
  description = "The Filestash container image. Pin a tag in production."
  type        = string
  default     = "machines/filestash:latest"
}

variable "port" {
  description = "Host port for the Filestash web UI. The container listens on 8334."
  type        = number
  default     = 8334
}

variable "application_url" {
  description = "Public URL Filestash is served at (APPLICATION_URL), used for share links. Empty = derive from the request."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for Filestash config and state (/app/data/state): the admin config, SQLite, and search index."
  type        = string
  default     = "filestash_data"
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
  description = "Resources for the Filestash task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
