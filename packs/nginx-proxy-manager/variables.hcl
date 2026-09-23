variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "nginx-proxy-manager"
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
  description = "The Nginx Proxy Manager container image. Pin a tag in production."
  type        = string
  default     = "jc21/nginx-proxy-manager:latest"
}

variable "http_port" {
  description = "Host port for proxied HTTP traffic."
  type        = number
  default     = 80
}

variable "https_port" {
  description = "Host port for proxied HTTPS traffic."
  type        = number
  default     = 443
}

variable "admin_port" {
  description = "Host port for the admin web UI."
  type        = number
  default     = 81
}

variable "data_volume" {
  description = "Named volume for NPM config and its SQLite database (/data)."
  type        = string
  default     = "npm_data"
}

variable "letsencrypt_volume" {
  description = "Named volume for issued TLS certificates (/etc/letsencrypt)."
  type        = string
  default     = "npm_letsencrypt"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
