variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dumbpad"
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
  description = "The DumbPad container image. Pin a tag in production."
  type        = string
  default     = "dumbwareio/dumbpad:latest"
}

variable "port" {
  description = "Host port for the DumbPad web UI."
  type        = number
  default     = 3000
}

variable "data_volume" {
  description = "Named volume mounted at /app/data (your notes)."
  type        = string
  default     = "dumbpad_data"
}

variable "base_url" {
  description = "Public URL DumbPad is reachable at (BASE_URL). Empty = http://localhost:<port>."
  type        = string
  default     = ""
}

variable "pin" {
  description = "Optional PIN protection, 4-10 digits (DUMBPAD_PIN). Empty = no auth."
  type        = string
  default     = ""
}

variable "site_title" {
  description = "Title shown in the header (SITE_TITLE)."
  type        = string
  default     = "DumbPad"
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
