variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "step-ca"
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
  description = "The step-ca container image. Pin a tag in production."
  type        = string
  default     = "smallstep/step-ca:latest"
}

variable "port" {
  description = "Host port for the CA's HTTPS API."
  type        = number
  default     = 9000
}

variable "ca_name" {
  description = "Name of the certificate authority (DOCKER_STEPCA_INIT_NAME), shown in certificates."
  type        = string
  default     = "Nomploy CA"
}

variable "dns_names" {
  description = "Comma-separated DNS names / IPs the CA will be reached at (DOCKER_STEPCA_INIT_DNS_NAMES). Include this host's name or IP."
  type        = string
  default     = "localhost"
}

variable "ca_password" {
  description = "Password protecting the CA's private keys (DOCKER_STEPCA_INIT_PASSWORD). CHANGE THIS and keep it safe — it is only used at first-boot initialization."
  type        = string
  default     = "change-me-please"
}

variable "data_volume" {
  description = "Named volume for the CA config, certs, and keys (/home/step). Losing it means losing your CA."
  type        = string
  default     = "stepca_data"
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
  description = "Resources for the step-ca task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
