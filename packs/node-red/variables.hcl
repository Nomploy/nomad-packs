variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "node-red"
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
  description = "The Node-RED container image. Pin a tag in production."
  type        = string
  default     = "nodered/node-red:latest"
}

variable "port" {
  description = "Host port for the Node-RED editor / dashboard (PORT env)."
  type        = number
  default     = 1880
}

variable "timezone" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
}

variable "data_volume" {
  description = "Docker named volume for /data (flows, credentials, installed nodes, settings). A prestart task chowns it to uid 1000 (the node-red user). Back it up."
  type        = string
  default     = "node_red_data"
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
    cpu    = 400
    memory = 256
  }
}
