variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "cyberchef"
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
  description = "The CyberChef container image (nginx serving the built app). Pin a tag in production."
  type        = string
  default     = "mpepping/cyberchef:latest"
}

variable "port" {
  description = "Host port for the web app. Default 8095 (the image serves on nginx internally; this pack rebinds it via a rendered nginx config)."
  type        = number
  default     = 8095
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
