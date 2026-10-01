variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "stalwart"
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
  description = "The Stalwart container image. Pin a tag in production."
  type        = string
  default     = "stalwartlabs/stalwart:latest"
}

variable "admin_port" {
  description = "Host port for the web admin / setup UI (and HTTP/JMAP)."
  type        = number
  default     = 8080
}

variable "admin_user" {
  description = "Recovery administrator username, pinned on first start."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Recovery administrator password, pinned on first start. CHANGE THIS."
  type        = string
  default     = "stalwart_change_me"
}

variable "smtp_port" {
  description = "Host port for SMTP (incoming mail / MX)."
  type        = number
  default     = 25
}

variable "submission_port" {
  description = "Host port for mail submission (STARTTLS)."
  type        = number
  default     = 587
}

variable "submissions_port" {
  description = "Host port for mail submission (implicit TLS)."
  type        = number
  default     = 465
}

variable "imap_port" {
  description = "Host port for IMAP (STARTTLS)."
  type        = number
  default     = 143
}

variable "imaps_port" {
  description = "Host port for IMAP (implicit TLS)."
  type        = number
  default     = 993
}

variable "sieve_port" {
  description = "Host port for ManageSieve."
  type        = number
  default     = 4190
}

variable "data_volume" {
  description = "Named volume for Stalwart config, data, queue and logs (/opt/stalwart)."
  type        = string
  default     = "stalwart_data"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\". A mail server usually wants a dedicated public node."
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
