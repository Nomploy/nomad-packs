variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "openbao"
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
  description = "The OpenBao container image. Pin a tag in production."
  type        = string
  default     = "openbao/openbao:latest"
}

variable "port" {
  description = "Host port for the OpenBao API / UI."
  type        = number
  default     = 8200
}

variable "data_volume" {
  description = "Docker named volume for OpenBao's file storage (/openbao/file) — encrypted secrets live here. A prestart task chowns it to the openbao user (uid 100). Back it up (and store your unseal keys separately)."
  type        = string
  default     = "openbao_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local storage volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
