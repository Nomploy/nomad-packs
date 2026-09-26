variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "etherpad"
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
  description = "The Etherpad container image. Pin a tag in production."
  type        = string
  default     = "etherpad/etherpad:latest"
}

variable "port" {
  description = "Host port for the Etherpad web UI. Fixed at 9001 inside the image."
  type        = number
  default     = 9001
}

variable "data_volume" {
  description = "Named volume mounted at /opt/etherpad-lite/var — the SQLite database and uploads."
  type        = string
  default     = "etherpad_data"
}

variable "admin_password" {
  description = "Password for the /admin settings UI (ADMIN_PASSWORD, user 'admin'). Empty = admin UI disabled."
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
    cpu    = 300
    memory = 256
  }
}
