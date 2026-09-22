variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "couchdb"
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
  description = "The Apache CouchDB container image. Pin a tag in production."
  type        = string
  default     = "couchdb:3"
}

variable "port" {
  description = "Host port for the CouchDB HTTP API (and Fauxton UI at /_utils)."
  type        = number
  default     = 5984
}

variable "admin_user" {
  description = "Admin username, created on first boot."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Admin password, created on first boot. CHANGE THIS."
  type        = string
  default     = "couchdb"
}

variable "data_volume" {
  description = "Docker named volume for /opt/couchdb/data (the databases). A prestart task chowns it to uid 5984 (the couchdb user). Back it up."
  type        = string
  default     = "couchdb_data"
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
    cpu    = 500
    memory = 512
  }
}
