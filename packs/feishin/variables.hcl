variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "feishin"
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
  description = "The Feishin container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/jeffvli/feishin:latest"
}

variable "port" {
  description = "Host port for the Feishin web UI."
  type        = number
  default     = 9180
}

variable "count" {
  description = "Number of instances to run (the app is stateless — settings live in the browser)."
  type        = number
  default     = 1
}

variable "server_type" {
  description = "Pre-select the backend type: jellyfin, navidrome or subsonic. Leave blank to choose in the UI."
  type        = string
  default     = ""
}

variable "server_url" {
  description = "Pre-fill the backend server URL (e.g. http://127.0.0.1:4533). Leave blank to set it in the UI."
  type        = string
  default     = ""
}

variable "server_lock" {
  description = "If \"true\", lock the server settings so users can't change them in the UI."
  type        = string
  default     = "false"
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
  description = "Resources for the Feishin task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
