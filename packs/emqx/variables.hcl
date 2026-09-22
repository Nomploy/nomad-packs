variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "emqx"
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
  description = "The EMQX container image. Pin a tag in production."
  type        = string
  default     = "emqx/emqx:5"
}

variable "mqtt_port" {
  description = "Host port for MQTT over TCP."
  type        = number
  default     = 1883
}

variable "ws_port" {
  description = "Host port for MQTT over WebSocket."
  type        = number
  default     = 8083
}

variable "dashboard_port" {
  description = "Host port for the EMQX dashboard and REST API."
  type        = number
  default     = 18083
}

variable "dashboard_password" {
  description = "Initial dashboard admin password (user \"admin\", EMQX_DASHBOARD__DEFAULT_PASSWORD). CHANGE THIS."
  type        = string
  default     = "public"
}

variable "uid" {
  description = "UID EMQX runs as. The data volume is chown'd to this at startup."
  type        = number
  default     = 1000
}

variable "data_volume" {
  description = "Named volume for EMQX data — retained messages, sessions, rules (/opt/emqx/data)."
  type        = string
  default     = "emqx_data"
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 512
  }
}
