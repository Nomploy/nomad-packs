variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "openobserve"
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
  description = "The OpenObserve container image. Pin a tag in production."
  type        = string
  default     = "public.ecr.aws/zinclabs/openobserve:latest"
}

variable "port" {
  description = "Host port for the OpenObserve web UI."
  type        = number
  default     = 5080
}

variable "data_volume" {
  description = "Named volume mounted at /data (the local metadata + object store)."
  type        = string
  default     = "openobserve_data"
}

variable "root_user_email" {
  description = "Initial admin email (ZO_ROOT_USER_EMAIL). Used to log in the first time."
  type        = string
  default     = "root@example.com"
}

variable "root_user_password" {
  description = "Initial admin password (ZO_ROOT_USER_PASSWORD). CHANGE THIS."
  type        = string
  default     = "change-me-a-strong-password"
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
    cpu    = 300
    memory = 256
  }
}
