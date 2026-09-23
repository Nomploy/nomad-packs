variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "jupyter"
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
  description = "The Jupyter image. minimal-notebook is lean; use scipy-notebook / datascience-notebook for batteries-included stacks. Pin a tag in production."
  type        = string
  default     = "quay.io/jupyter/minimal-notebook:latest"
}

variable "port" {
  description = "Host port for the Jupyter web UI."
  type        = number
  default     = 8110
}

variable "token" {
  description = "Access token required to log in (JUPYTER_TOKEN). CHANGE THIS — anyone with the token gets a Python shell. Empty disables auth (unsafe)."
  type        = string
  default     = "change-me-to-a-long-random-token"
}

variable "work_volume" {
  description = "Named volume for notebooks and files (/home/jovyan/work)."
  type        = string
  default     = "jupyter_work"
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
  description = "Resources for the Jupyter task. Notebooks running data workloads may need much more memory."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
