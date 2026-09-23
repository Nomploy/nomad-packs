variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "microbin"
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
  description = "The MicroBin container image. Pin a tag in production."
  type        = string
  default     = "danielszabo99/microbin:latest"
}

variable "port" {
  description = "Host port for the MicroBin web UI (MICROBIN_PORT)."
  type        = number
  default     = 8109
}

variable "public_url" {
  description = "Public base URL (MICROBIN_PUBLIC_PATH), used for generated links/QR codes. Empty = http://localhost:<port>."
  type        = string
  default     = ""
}

variable "admin_username" {
  description = "Admin username (MICROBIN_ADMIN_USERNAME)."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Admin password (MICROBIN_ADMIN_PASSWORD). CHANGE THIS."
  type        = string
  default     = "changeme-please"
}

variable "data_volume" {
  description = "Named volume for pastas, uploaded files, and the database (/app/microbin_data)."
  type        = string
  default     = "microbin_data"
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
