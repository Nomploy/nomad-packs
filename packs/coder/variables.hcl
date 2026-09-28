variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "coder"
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
  description = "The Coder container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/coder/coder:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:17-alpine"
}

variable "port" {
  description = "Host port for the Coder web UI / API."
  type        = number
  default     = 7080
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "coder_change_me"
}

variable "access_url" {
  description = "Public URL clients use to reach Coder (set to the node's address). If empty, Coder creates a temporary tunnel."
  type        = string
  default     = "http://localhost:7080"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "coder_db_data"
}

variable "home_volume" {
  description = "Named volume for the Coder server home directory (/home/coder)."
  type        = string
  default     = "coder_home"
}

variable "docker_sock" {
  description = "Host path to the Docker socket, bind-mounted so the built-in Docker template can create workspaces. Set to empty to disable."
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
  description = "Resources for the Coder server task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "db_resources" {
  description = "Resources for the bundled PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
