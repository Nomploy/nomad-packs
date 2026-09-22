variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "grist"
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
  description = "The Grist container image. Pin a tag in production."
  type        = string
  default     = "gristlabs/grist:latest"
}

variable "port" {
  description = "Host port for the Grist web UI (PORT)."
  type        = number
  default     = 8484
}

variable "session_secret" {
  description = "Secret used to sign session cookies (GRIST_SESSION_SECRET). Set a long random value."
  type        = string
  default     = "change-me-to-a-long-random-session-secret"
}

variable "default_email" {
  description = "Email of the initial admin/owner (GRIST_DEFAULT_EMAIL). Empty = not set."
  type        = string
  default     = ""
}

variable "app_home_url" {
  description = "Public base URL Grist is served at (APP_HOME_URL), e.g. http://<host>:8484. Empty = not set."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for Grist documents and its SQLite metadata (/persist)."
  type        = string
  default     = "grist_data"
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
    cpu    = 500
    memory = 512
  }
}
