variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "glance"
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
  description = "The Glance container image. Pin a tag in production."
  type        = string
  default     = "glanceapp/glance:latest"
}

variable "port" {
  description = "Host port for the Glance dashboard."
  type        = number
  default     = 3009
}

variable "pages" {
  description = "The `pages:` section of the Glance config (YAML). Replace the default with your own pages/columns/widgets — see the Glance docs for the full widget set (RSS, weather, monitor, docker, etc.)."
  type        = string
  default     = <<-EOT
      - name: Home
        columns:
          - size: full
            widgets:
              - type: clock
              - type: search
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
    memory = 128
  }
}
