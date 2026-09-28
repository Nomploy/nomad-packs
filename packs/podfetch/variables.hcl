variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "podfetch"
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
  description = "The PodFetch container image. Pin a tag in production."
  type        = string
  default     = "samuel19982/podfetch:latest"
}

variable "port" {
  description = "Host port for the PodFetch web UI."
  type        = number
  default     = 8000
}

variable "server_url" {
  description = "Public URL where PodFetch is served (used for feed/RSS links)."
  type        = string
  default     = "http://localhost:8000"
}

variable "polling_interval" {
  description = "How often (minutes) to check subscriptions for new episodes."
  type        = number
  default     = 60
}

variable "podcasts_volume" {
  description = "Named volume for downloaded episodes (/app/podcasts)."
  type        = string
  default     = "podfetch_podcasts"
}

variable "db_volume" {
  description = "Named volume for the SQLite database (/app/db)."
  type        = string
  default     = "podfetch_db"
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
