variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ejabberd"
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
  description = "The ejabberd (ecs) container image. Pin a tag in production."
  type        = string
  default     = "ejabberd/ecs:latest"
}

variable "c2s_port" {
  description = "Host port for client-to-server XMPP (c2s)."
  type        = number
  default     = 5222
}

variable "s2s_port" {
  description = "Host port for server-to-server XMPP (s2s / federation)."
  type        = number
  default     = 5269
}

variable "admin_port" {
  description = "Host port for the web admin / HTTP API."
  type        = number
  default     = 5280
}

variable "xmpp_domain" {
  description = "The XMPP virtual host (your Jabber domain)."
  type        = string
  default     = "localhost"
}

variable "admin_user" {
  description = "Admin account username (localpart)."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Admin account password, registered on first start. CHANGE THIS."
  type        = string
  default     = "ejabberd_change_me"
}

variable "data_volume" {
  description = "Named volume for the ejabberd database (/home/ejabberd/database)."
  type        = string
  default     = "ejabberd_data"
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
    cpu    = 500
    memory = 512
  }
}
