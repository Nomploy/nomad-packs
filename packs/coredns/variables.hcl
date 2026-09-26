variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "coredns"
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
  description = "The CoreDNS container image. Pin a tag in production."
  type        = string
  default     = "coredns/coredns:latest"
}

variable "port" {
  description = "DNS port (TCP + UDP)."
  type        = number
  default     = 53
}

variable "upstreams" {
  description = "Upstream DNS servers to forward to, space-separated (used in the generated Corefile)."
  type        = string
  default     = "1.1.1.1 9.9.9.9"
}

variable "corefile" {
  description = "Optional full Corefile contents. Leave empty to use the generated caching-forwarder config; set this to take full control (blocklists, hosts, custom zones, etc.)."
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
