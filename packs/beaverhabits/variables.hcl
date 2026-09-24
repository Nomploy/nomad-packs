variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "beaverhabits"
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
  description = "The Beaver Habit Tracker container image. Pin a tag in production."
  type        = string
  default     = "daya0576/beaverhabits:latest"
}

variable "port" {
  description = "Host port for the web UI. The container listens on 8080."
  type        = number
  default     = 8080
}

variable "storage" {
  description = "Storage backend (HABITS_STORAGE): DATABASE (single SQLite db) or USER_DISK (a JSON file per user)."
  type        = string
  default     = "DATABASE"
}

variable "data_volume" {
  description = "Named volume for habit data (/app/.user): the SQLite database or per-user JSON files."
  type        = string
  default     = "beaverhabits_data"
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
  description = "Resources for the Beaver Habits task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
