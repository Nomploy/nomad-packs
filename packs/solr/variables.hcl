variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "solr"
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
  description = "The Apache Solr container image. Pin a tag in production."
  type        = string
  default     = "solr:9"
}

variable "port" {
  description = "Host port for the Solr server / admin UI."
  type        = number
  default     = 8983
}

variable "data_volume" {
  description = "Named volume for Solr data and cores (/var/solr)."
  type        = string
  default     = "solr_data"
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
