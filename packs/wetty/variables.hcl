variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "wetty"
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
  description = "The WeTTY container image. Pin a tag in production."
  type        = string
  default     = "wettyoss/wetty:latest"
}

variable "port" {
  description = "Host port for the WeTTY web terminal (--port)."
  type        = number
  default     = 3011
}

variable "ssh_host" {
  description = "SSH server WeTTY connects to (--ssh-host). Use host.docker.internal or a reachable hostname/IP."
  type        = string
  default     = "127.0.0.1"
}

variable "ssh_port" {
  description = "SSH server port (--ssh-port)."
  type        = number
  default     = 22
}

variable "ssh_user" {
  description = "Default SSH username to pre-fill (--ssh-user). Empty = prompt for the username."
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
  description = "Resources for the WeTTY task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
