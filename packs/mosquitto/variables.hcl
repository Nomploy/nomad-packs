variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "mosquitto"
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
  description = "The Eclipse Mosquitto container image. Pin a tag in production."
  type        = string
  default     = "eclipse-mosquitto:2"
}

variable "port" {
  description = "Host port for the MQTT listener (TCP)."
  type        = number
  default     = 1883
}

variable "allow_anonymous" {
  description = "Allow clients to connect without credentials. Fine on a trusted network; set false and manage a password file for real use."
  type        = bool
  default     = true
}

variable "data_volume" {
  description = "Docker named volume for /mosquitto/data (retained messages / persistence DB). A prestart task chowns it to uid 1883 (the mosquitto user)."
  type        = string
  default     = "mosquitto_data"
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
    cpu    = 200
    memory = 128
  }
}
