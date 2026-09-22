variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "blackbox-exporter"
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
  description = "The Prometheus Blackbox Exporter image. Pin a tag in production."
  type        = string
  default     = "prom/blackbox-exporter:latest"
}

variable "port" {
  description = "Host port for the exporter (/probe and /metrics)."
  type        = number
  default     = 9115
}

variable "config" {
  description = "Full blackbox.yml contents (modules). The default provides http_2xx, tcp_connect, and icmp probers — extend it as needed."
  type        = string
  default     = <<-EOT
    modules:
      http_2xx:
        prober: http
        timeout: 5s
        http:
          preferred_ip_protocol: ip4
      tcp_connect:
        prober: tcp
        timeout: 5s
      icmp:
        prober: icmp
        timeout: 5s
  EOT
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
    memory = 64
  }
}
