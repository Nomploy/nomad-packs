variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "pocketbase"
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
  description = "The PocketBase container image. PocketBase has no official image; this is the widely-used community build. Pin a tag in production."
  type        = string
  default     = "ghcr.io/muchobien/pocketbase:latest"
}

variable "port" {
  description = "Host port for PocketBase (admin UI at /_/ and the REST/realtime API)."
  type        = number
  default     = 8090
}

variable "data_volume" {
  description = "Docker named volume for /pb_data (SQLite database, uploaded files, settings). All of PocketBase's state. Back it up."
  type        = string
  default     = "pocketbase_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
