variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "activemq"
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
  description = "The ActiveMQ Artemis container image. Pin a tag in production."
  type        = string
  default     = "apache/activemq-artemis:latest-alpine"
}

variable "port" {
  description = "Host port for the web management console."
  type        = number
  default     = 8161
}

variable "core_port" {
  description = "Host port for the core/OpenWire protocol."
  type        = number
  default     = 61616
}

variable "amqp_port" {
  description = "Host port for AMQP."
  type        = number
  default     = 5672
}

variable "mqtt_port" {
  description = "Host port for MQTT."
  type        = number
  default     = 1883
}

variable "stomp_port" {
  description = "Host port for STOMP."
  type        = number
  default     = 61613
}

variable "admin_user" {
  description = "Broker admin username."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Broker admin password. CHANGE THIS."
  type        = string
  default     = "activemq_change_me"
}

variable "data_volume" {
  description = "Named volume for the broker instance (data, config, logs) (/var/lib/artemis-instance)."
  type        = string
  default     = "activemq_data"
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
    cpu    = 1000
    memory = 1024
  }
}
