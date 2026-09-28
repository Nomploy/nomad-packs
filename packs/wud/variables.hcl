variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "wud"
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
  description = "The WUD container image. Pin a tag in production."
  type        = string
  default     = "getwud/wud:latest"
}

variable "port" {
  description = "Host port for the WUD web UI."
  type        = number
  default     = 3000
}

variable "admin_user" {
  description = "Web UI admin username."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Web UI admin password. CHANGE THIS."
  type        = string
  default     = "wud_change_me"
}

variable "docker_sock" {
  description = "Host path to the Docker socket to watch. Bind-mounted read-only."
  type        = string
  default     = "/var/run/docker.sock"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\". Pin to the node whose containers you want watched."
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
    cpu    = 200
    memory = 256
  }
}
