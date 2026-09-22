variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "neo4j"
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
  description = "The Neo4j container image. Pin a tag in production."
  type        = string
  default     = "neo4j:5"
}

variable "http_port" {
  description = "Host port for the Neo4j Browser / HTTP API."
  type        = number
  default     = 7474
}

variable "bolt_port" {
  description = "Host port for the Bolt protocol (drivers connect here)."
  type        = number
  default     = 7687
}

variable "password" {
  description = "Initial password for the built-in `neo4j` user (min 8 chars; must NOT be \"neo4j\"). CHANGE THIS."
  type        = string
  default     = "changeme123"
}

variable "data_volume" {
  description = "Docker named volume for /data (the graph store). A prestart task chowns it to uid 7474 (the neo4j user). Back it up."
  type        = string
  default     = "neo4j_data"
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
  description = "The task resources. Neo4j (JVM) likes memory — raise for larger graphs."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
