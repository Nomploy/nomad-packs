variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "pulsar"
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
  description = "The Apache Pulsar container image. Pin a tag in production."
  type        = string
  default     = "apachepulsar/pulsar:latest"
}

variable "broker_port" {
  description = "Host port for the Pulsar binary protocol (pulsar://)."
  type        = number
  default     = 6650
}

variable "http_port" {
  description = "Host port for the admin / REST HTTP service."
  type        = number
  default     = 8080
}

variable "pulsar_mem" {
  description = "JVM memory flags for the standalone process. Raise for real workloads."
  type        = string
  default     = "-Xms1g -Xmx1g -XX:MaxDirectMemorySize=512m"
}

variable "data_volume" {
  description = "Named volume for Pulsar data (BookKeeper + metadata) (/pulsar/data)."
  type        = string
  default     = "pulsar_data"
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
    cpu    = 1500
    memory = 2560
  }
}
