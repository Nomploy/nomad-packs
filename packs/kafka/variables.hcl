variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kafka"
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
  description = "The Apache Kafka container image. Pin a tag in production."
  type        = string
  default     = "apache/kafka:3.9.1"
}

variable "port" {
  description = "Host port for the Kafka broker (PLAINTEXT client listener)."
  type        = number
  default     = 9092
}

variable "controller_port" {
  description = "Host port for the KRaft controller listener."
  type        = number
  default     = 9093
}

variable "advertised_host" {
  description = "Host/IP that clients use to reach this broker. Set to the node's address for external clients."
  type        = string
  default     = "localhost"
}

variable "data_volume" {
  description = "Named volume for Kafka log data (/var/lib/kafka/data)."
  type        = string
  default     = "kafka_data"
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
    memory = 1536
  }
}
