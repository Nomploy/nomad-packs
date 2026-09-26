variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dumbbudget"
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
  description = "The DumbBudget container image. Pin a tag in production."
  type        = string
  default     = "dumbwareio/dumbbudget:latest"
}

variable "port" {
  description = "Host port for the DumbBudget web UI."
  type        = number
  default     = 3000
}

variable "data_volume" {
  description = "Named volume mounted at /app/data (the transactions database)."
  type        = string
  default     = "dumbbudget_data"
}

variable "pin" {
  description = "PIN lock, 4-10 digits (DUMBBUDGET_PIN). REQUIRED — DumbBudget will not start without it. Set your own."
  type        = string
  default     = ""
}

variable "currency" {
  description = "ISO 4217 currency code (CURRENCY), e.g. USD, EUR, GBP."
  type        = string
  default     = "USD"
}

variable "base_url" {
  description = "Public URL DumbBudget is reachable at (BASE_URL). Empty = http://localhost:<port>."
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
