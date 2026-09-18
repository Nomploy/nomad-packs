variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "stirling-pdf"
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
  description = "The Stirling-PDF container image. Use a `-fat` tag if you need OCR/extra features. Pin a tag in production."
  type        = string
  default     = "stirlingtools/stirling-pdf:latest"
}

variable "port" {
  description = "Host port for the web UI. Default 8096 (the app listens on 8080 by default; set via SERVER_PORT)."
  type        = number
  default     = 8096
}

variable "enable_login" {
  description = "Enable Stirling-PDF's built-in login/user management. When true, set an initial admin via env in the rendered job or the first-run flow. Default false = open (keep it internal)."
  type        = bool
  default     = false
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
  description = "The task resources. Raise memory for OCR / large PDFs."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
