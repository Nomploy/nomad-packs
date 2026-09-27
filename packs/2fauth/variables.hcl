variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "2fauth"
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
  description = "The 2FAuth container image. Pin a tag in production."
  type        = string
  default     = "2fauth/2fauth:latest"
}

variable "port" {
  description = "Host port for the 2FAuth web UI."
  type        = number
  default     = 8000
}

variable "data_volume" {
  description = "Named volume mounted at /2fauth (the SQLite database)."
  type        = string
  default     = "2fauth_data"
}

variable "app_key" {
  description = "Laravel app key (APP_KEY). MUST be exactly 32 characters and CHANGE THIS — it encrypts your stored secrets, so keep it stable. Generate with: openssl rand -base64 24 | cut -c1-32."
  type        = string
  default     = "0123456789abcdef0123456789abcdef"
}

variable "base_url" {
  description = "Public URL 2FAuth is reachable at (APP_URL). Empty = http://localhost:<port>."
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
