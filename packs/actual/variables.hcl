variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "actual"
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
  description = "The Actual Budget server container image. Pin a tag in production."
  type        = string
  default     = "actualbudget/actual-server:latest"
}

variable "port" {
  description = "Host port for the Actual web app / sync server (ACTUAL_PORT)."
  type        = number
  default     = 5006
}

variable "data_volume" {
  description = "Docker named volume for /data (the budget files + server DB). A prestart task chowns it to uid 1000 (the node user). Back it up."
  type        = string
  default     = "actual_data"
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
