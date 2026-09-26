variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "komf"
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
  description = "The Komf container image. Pin a tag in production."
  type        = string
  default     = "sndxr/komf:latest"
}

variable "port" {
  description = "Host port for the Komf web UI."
  type        = number
  default     = 8085
}

variable "data_volume" {
  description = "Named volume mounted at /config (application.yml and the state database)."
  type        = string
  default     = "komf_data"
}

variable "komga_url" {
  description = "Optional Komga base URL (KOMF_KOMGA_BASE_URI), e.g. http://127.0.0.1:25600. Empty = configure in application.yml / the web UI."
  type        = string
  default     = ""
}

variable "kavita_url" {
  description = "Optional Kavita base URL (KOMF_KAVITA_BASE_URI), e.g. http://127.0.0.1:5000. Empty = configure in application.yml / the web UI."
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
