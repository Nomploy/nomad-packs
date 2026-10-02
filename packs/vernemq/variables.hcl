variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "vernemq"
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
  description = "The VerneMQ container image. Pin a tag in production."
  type        = string
  default     = "vernemq/vernemq:latest"
}

variable "mqtt_port" {
  description = "Host port for MQTT."
  type        = number
  default     = 1883
}

variable "http_port" {
  description = "Host port for the HTTP status page / metrics / health."
  type        = number
  default     = 8888
}

variable "allow_anonymous" {
  description = "Allow anonymous MQTT clients (on/off). Turn off and configure auth for production."
  type        = string
  default     = "on"
}

variable "data_volume" {
  description = "Named volume for VerneMQ message store / metadata (/vernemq/data)."
  type        = string
  default     = "vernemq_data"
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
