variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "gatus"
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
  description = "The Gatus container image. Pin a tag in production."
  type        = string
  default     = "twinproduction/gatus:latest"
}

variable "port" {
  description = "Host port for the Gatus status page (its config web.port is set to this)."
  type        = number
  default     = 8101
}

variable "endpoints" {
  description = "The `endpoints:` section of the Gatus config (YAML). Replace the default sample with the services you want to monitor. See https://gatus.io for the full syntax (groups, conditions, alerts)."
  type        = string
  default     = <<-EOT
      - name: example
        url: "https://example.org"
        interval: 60s
        conditions:
          - "[STATUS] == 200"
  EOT
}

variable "constraints" {
  description = "Placement constraints. Gatus probes from the node it runs on. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
