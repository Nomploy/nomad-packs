variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "code-server"
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
  description = "The code-server container image. Pin a tag in production."
  type        = string
  default     = "codercom/code-server:latest"
}

variable "port" {
  description = "Host port for the code-server web UI. Default 8093 to avoid common clashes."
  type        = number
  default     = 8093
}

variable "password" {
  description = "Password for the web UI. CHANGE THIS — it is baked into the job env."
  type        = string
  default     = "changeme"
}

variable "data_volume" {
  description = "Docker named volume for /home/coder (config, extensions, and your files). A prestart task chowns it to uid 1000 (the coder user) so code-server can write it. Back it up."
  type        = string
  default     = "code_server_data"
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
    cpu    = 1000
    memory = 1024
  }
}
