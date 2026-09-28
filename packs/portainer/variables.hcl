variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "portainer"
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
  description = "The Portainer CE container image. Pin a tag in production."
  type        = string
  default     = "portainer/portainer-ce:latest"
}

variable "port" {
  description = "Host port for the Portainer web UI (HTTPS)."
  type        = number
  default     = 9443
}

variable "http_port" {
  description = "Host port for the Portainer web UI (HTTP)."
  type        = number
  default     = 9000
}

variable "data_volume" {
  description = "Named volume for Portainer data (/data)."
  type        = string
  default     = "portainer_data"
}

variable "docker_sock" {
  description = "Host path to the Docker socket that Portainer manages."
  type        = string
  default     = "/var/run/docker.sock"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\". Pin to the node whose Docker you want to manage."
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
