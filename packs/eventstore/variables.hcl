variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "eventstore"
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
  description = "The EventStoreDB container image. Pin a tag in production."
  type        = string
  default     = "eventstore/eventstore:lts"
}

variable "port" {
  description = "Host port for the HTTP API, gRPC clients, and web admin UI (EVENTSTORE_HTTP_PORT)."
  type        = number
  default     = 2113
}

variable "run_projections" {
  description = "Which projections to run (EVENTSTORE_RUN_PROJECTIONS): None, System, or All."
  type        = string
  default     = "All"
}

variable "data_volume" {
  description = "Named volume for event data (/var/lib/eventstore). Holds all streams and events."
  type        = string
  default     = "eventstore_data"
}

variable "logs_volume" {
  description = "Named volume for logs (/var/log/eventstore)."
  type        = string
  default     = "eventstore_logs"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the EventStoreDB task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
