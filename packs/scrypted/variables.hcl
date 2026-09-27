variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "scrypted"
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
  description = "The Scrypted container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/koush/scrypted:latest"
}

variable "port" {
  description = "Host port for the Scrypted management console (HTTPS)."
  type        = number
  default     = 10443
}

variable "http_port" {
  description = "Host port for the Scrypted HTTP endpoint."
  type        = number
  default     = 11080
}

variable "data_volume" {
  description = "Named volume for the Scrypted server state and plugins (/server/volume)."
  type        = string
  default     = "scrypted_volume"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\". Pin to the node on the camera LAN."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources. Camera transcoding benefits from more CPU."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 2048
  }
}
