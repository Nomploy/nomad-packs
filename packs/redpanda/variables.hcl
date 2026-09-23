variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "redpanda"
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
  description = "The Redpanda container image. Pin a tag in production."
  type        = string
  default     = "redpandadata/redpanda:latest"
}

variable "kafka_port" {
  description = "Host port for the Kafka API."
  type        = number
  default     = 9092
}

variable "admin_port" {
  description = "Host port for the Redpanda Admin API."
  type        = number
  default     = 9644
}

variable "proxy_port" {
  description = "Host port for the HTTP (Panda) Proxy."
  type        = number
  default     = 8082
}

variable "schema_port" {
  description = "Host port for the Schema Registry."
  type        = number
  default     = 8081
}

variable "advertise_host" {
  description = "Host/IP advertised to Kafka clients. 127.0.0.1 works for co-located clients; set this to the node's IP for remote consumers/producers."
  type        = string
  default     = "127.0.0.1"
}

variable "uid" {
  description = "UID Redpanda runs as. The data volume is chown'd to this at startup."
  type        = number
  default     = 101
}

variable "data_volume" {
  description = "Named volume for Redpanda's data (/var/lib/redpanda/data)."
  type        = string
  default     = "redpanda_data"
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
    memory = 1024
  }
}
