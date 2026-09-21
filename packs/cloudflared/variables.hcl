variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "cloudflared"
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
  description = "The cloudflared container image. Pin a tag in production."
  type        = string
  default     = "cloudflare/cloudflared:latest"
}

variable "tunnel_token" {
  description = "REQUIRED. The tunnel token from the Cloudflare Zero Trust dashboard (Networks → Tunnels → your tunnel → install token). Treat it as a secret. Configure which hostname maps to which local service (e.g. http://127.0.0.1:8080) in the dashboard."
  type        = string
  default     = ""
}

variable "count" {
  description = "Number of connector replicas (Cloudflare load-balances across them; 2+ gives HA)."
  type        = number
  default     = 1
}

variable "constraints" {
  description = "Placement constraints. Host networking lets the connector reach services on 127.0.0.1. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
