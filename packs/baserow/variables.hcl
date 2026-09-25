variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "baserow"
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
  description = "The Baserow container image. Pin a tag in production."
  type        = string
  default     = "baserow/baserow:latest"
}

variable "port" {
  description = "Host port for the Baserow web UI."
  type        = number
  default     = 3001
}

variable "data_volume" {
  description = "Named volume mounted at /baserow/data — the embedded PostgreSQL, Redis state and uploaded files."
  type        = string
  default     = "baserow_data"
}

variable "base_url" {
  description = "Public URL Baserow is reachable at (BASEROW_PUBLIC_URL). MUST match the address users open, including the port, or the app breaks. Empty = http://localhost:<port>. Set this to your real host/domain."
  type        = string
  default     = ""
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
    cpu    = 1500
    memory = 2048
  }
}
