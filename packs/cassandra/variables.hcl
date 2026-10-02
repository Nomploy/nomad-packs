variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "cassandra"
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
  description = "The Cassandra container image. Pin a tag in production."
  type        = string
  default     = "cassandra:5"
}

variable "port" {
  description = "Host port for the CQL native protocol (clients)."
  type        = number
  default     = 9042
}

variable "internode_port" {
  description = "Host port for inter-node communication (clustering)."
  type        = number
  default     = 7000
}

variable "cluster_name" {
  description = "The Cassandra cluster name."
  type        = string
  default     = "Nomploy Cluster"
}

variable "max_heap_size" {
  description = "JVM max heap. Set within the task memory limit (Cassandra otherwise auto-sizes to host RAM)."
  type        = string
  default     = "2G"
}

variable "heap_newsize" {
  description = "JVM young-generation heap size."
  type        = string
  default     = "400M"
}

variable "data_volume" {
  description = "Named volume for Cassandra data (/var/lib/cassandra)."
  type        = string
  default     = "cassandra_data"
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
  description = "The task resources. Cassandra is JVM/memory-heavy — keep memory above max_heap_size + off-heap."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1500
    memory = 3072
  }
}
