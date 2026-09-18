variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "it-tools"
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
  description = "The IT Tools container image (nginx serving the built app). Pin a tag in production."
  type        = string
  default     = "corentinth/it-tools:latest"
}

variable "port" {
  description = "Host port for the web app. Default 8092 to avoid common clashes (the image serves on 80 internally; this pack rebinds it via a rendered nginx config)."
  type        = number
  default     = 8092
}

variable "count" {
  description = "Number of instances (stateless, so >1 is fine on distinct ports/nodes)."
  type        = number
  default     = 1
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
    cpu    = 200
    memory = 128
  }
}
