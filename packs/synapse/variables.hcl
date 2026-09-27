variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "synapse"
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
  description = "The Synapse container image. Pin a tag in production."
  type        = string
  default     = "matrixdotorg/synapse:latest"
}

variable "port" {
  description = "Host port for the Synapse client-server API (HTTP)."
  type        = number
  default     = 8008
}

variable "server_name" {
  description = "The Matrix server name (SYNAPSE_SERVER_NAME). This becomes part of every user ID (@user:server_name) and CANNOT be changed later — set it to your real domain before first start."
  type        = string
  default     = "localhost"
}

variable "report_stats" {
  description = "Whether to report anonymous usage statistics (SYNAPSE_REPORT_STATS): yes or no."
  type        = string
  default     = "no"
}

variable "data_volume" {
  description = "Named volume mounted at /data — config, signing keys, media and the SQLite database."
  type        = string
  default     = "synapse_data"
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
    memory = 1024
  }
}
