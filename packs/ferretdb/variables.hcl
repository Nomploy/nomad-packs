variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ferretdb"
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
  description = "The FerretDB image (v2). Pin a tag in production."
  type        = string
  default     = "ghcr.io/ferretdb/ferretdb:2"
}

variable "port" {
  description = "Host port for the MongoDB wire protocol — point your Mongo client/driver here."
  type        = number
  default     = 27017
}

variable "postgres_image" {
  description = "The DocumentDB-enabled PostgreSQL image FerretDB v2 requires. Keep the major (17/16/15) matched to a tested FerretDB version; pin a full tag in production."
  type        = string
  default     = "ghcr.io/ferretdb/postgres-documentdb:17"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on. FerretDB connects on 127.0.0.1."
  type        = number
  default     = 5432
}

variable "db_user" {
  description = "PostgreSQL user FerretDB connects as — this is also the MongoDB username your clients use."
  type        = string
  default     = "ferretdb"
}

variable "db_password" {
  description = "Password for db_user (also the MongoDB password). CHANGE THIS."
  type        = string
  default     = "ferretdb"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir (all your documents). A fresh volume inherits the image's data-dir ownership. Back it up."
  type        = string
  default     = "ferretdb_db_data"
}

variable "ferretdb_resources" {
  description = "Resources for the FerretDB task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "postgres_resources" {
  description = "Resources for the PostgreSQL (DocumentDB) task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "constraints" {
  description = "Placement constraints — pin the job to one node so the Postgres local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}
