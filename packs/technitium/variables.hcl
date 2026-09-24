variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "technitium"
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
  description = "The Technitium DNS Server image. Pin a tag in production."
  type        = string
  default     = "technitium/dns-server:latest"
}

variable "dns_port" {
  description = "Host port for DNS queries (UDP + TCP), port 53."
  type        = number
  default     = 53
}

variable "web_port" {
  description = "Host port for the web console (DNS_SERVER_WEB_SERVICE_HTTP_PORT)."
  type        = number
  default     = 5380
}

variable "admin_password" {
  description = "Web console admin password (DNS_SERVER_ADMIN_PASSWORD) for the 'admin' user. CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "data_volume" {
  description = "Named volume for Technitium config and zones (/etc/dns)."
  type        = string
  default     = "technitium_config"
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
  description = "Resources for the Technitium task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
