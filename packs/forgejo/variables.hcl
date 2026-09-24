variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "forgejo"
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
  description = "The Forgejo container image. Pin a tag in production."
  type        = string
  default     = "codeberg.org/forgejo/forgejo:latest"
}

variable "http_port" {
  description = "Host port for the web UI / API."
  type        = number
  default     = 3030
}

variable "ssh_port" {
  description = "Host port for Git-over-SSH."
  type        = number
  default     = 2223
}

variable "root_url" {
  description = "Public URL Forgejo is served at (ROOT_URL), e.g. https://git.example.com/. Empty = derive from the request."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for Forgejo data (/data): the SQLite database, repositories, and config."
  type        = string
  default     = "forgejo_data"
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
  description = "Resources for the Forgejo task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
