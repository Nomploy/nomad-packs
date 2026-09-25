variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "rustpad"
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
  description = "The Rustpad container image. Pin a tag in production."
  type        = string
  default     = "ekzhang/rustpad:latest"
}

variable "port" {
  description = "Host port for the Rustpad web UI."
  type        = number
  default     = 3030
}

variable "data_volume" {
  description = "Named volume mounted at /data (SQLite persistence for documents)."
  type        = string
  default     = "rustpad_data"
}

variable "expiry_days" {
  description = "Days a document is kept after its last edit before garbage collection (EXPIRY_DAYS)."
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
    cpu    = 300
    memory = 256
  }
}
