variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "gel"
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
  description = "The Gel container image. Pin a tag in production."
  type        = string
  default     = "geldata/gel:latest"
}

variable "port" {
  description = "Host port for the Gel server (binary + HTTP protocol)."
  type        = number
  default     = 5656
}

variable "server_password" {
  description = "Password for the default 'admin' user. CHANGE THIS."
  type        = string
  default     = "gel_change_me"
}

variable "tls_cert_mode" {
  description = "TLS certificate mode: generate_self_signed (default) auto-creates a cert; set to require_file if you mount your own."
  type        = string
  default     = "generate_self_signed"
}

variable "data_volume" {
  description = "Named volume for Gel's data (bundled PostgreSQL) (/var/lib/gel/data)."
  type        = string
  default     = "gel_data"
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
    cpu    = 1000
    memory = 1024
  }
}
