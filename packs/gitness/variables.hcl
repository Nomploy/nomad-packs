variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "gitness"
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
  description = "The Harness/Gitness container image. Pin a tag in production."
  type        = string
  default     = "harness/harness:latest"
}

variable "port" {
  description = "Host port for the web UI / API (HTTP)."
  type        = number
  default     = 3000
}

variable "ssh_port" {
  description = "Host port for Git over SSH."
  type        = number
  default     = 3022
}

variable "data_volume" {
  description = "Named volume for the database and repositories (/data)."
  type        = string
  default     = "gitness_data"
}

variable "docker_sock" {
  description = "Host path to the Docker socket, bind-mounted so CI/CD pipelines can run. Set to empty to disable pipelines."
  type        = string
  default     = "/var/run/docker.sock"
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
    memory = 1024
  }
}
