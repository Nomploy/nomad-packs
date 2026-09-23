variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "pairdrop"
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
  description = "The PairDrop container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/schlagmichdoch/pairdrop:latest"
}

variable "port" {
  description = "Host port for the PairDrop web UI (PORT)."
  type        = number
  default     = 3017
}

variable "rate_limit" {
  description = "Enable per-IP rate limiting (RATE_LIMIT)."
  type        = bool
  default     = false
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
