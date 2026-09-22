variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "pgadmin"
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
  description = "The pgAdmin 4 container image. Pin a tag in production."
  type        = string
  default     = "dpage/pgadmin4:latest"
}

variable "port" {
  description = "Host port for the pgAdmin web UI (PGADMIN_LISTEN_PORT)."
  type        = number
  default     = 5050
}

variable "email" {
  description = "Initial login email (must be a valid email format). Created on first boot."
  type        = string
  default     = "admin@example.com"
}

variable "password" {
  description = "Initial login password. CHANGE THIS."
  type        = string
  default     = "admin"
}

variable "data_volume" {
  description = "Docker named volume for /var/lib/pgadmin (saved server connections, preferences). A prestart task chowns it to uid 5050 (the pgadmin user)."
  type        = string
  default     = "pgadmin_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
