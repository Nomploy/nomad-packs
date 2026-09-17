variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "adminer"
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
  description = "The Adminer container image."
  type        = string
  default     = "adminer:latest"
}

variable "port" {
  description = "Host port for the Adminer web UI. Default 8083 to avoid common 8080 clashes (nginx/fleet/keycloak)."
  type        = number
  default     = 8083
}

variable "default_server" {
  description = "Optional DB server host:port to pre-fill on the login page (e.g. 127.0.0.1:5432 for the postgres pack). Empty = leave the field blank."
  type        = string
  default     = ""
}

variable "design" {
  description = "Optional Adminer CSS theme name (e.g. dracula, pepa-linha, nette). Empty = default theme."
  type        = string
  default     = ""
}

variable "count" {
  description = "Number of instances (Adminer is stateless, so this can be >1 if you give each a distinct port/node)."
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
    cpu    = 200
    memory = 128
  }
}
