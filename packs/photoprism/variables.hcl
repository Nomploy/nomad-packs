variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "photoprism"
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
  description = "The PhotoPrism container image. Pin a tag in production."
  type        = string
  default     = "photoprism/photoprism:latest"
}

variable "port" {
  description = "Host port for the PhotoPrism web UI."
  type        = number
  default     = 2342
}

variable "admin_user" {
  description = "Initial admin username (PHOTOPRISM_ADMIN_USER)."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Initial admin password (PHOTOPRISM_ADMIN_PASSWORD, min 8 chars). CHANGE THIS."
  type        = string
  default     = "changeme-please"
}

variable "site_url" {
  description = "Public site URL (PHOTOPRISM_SITE_URL). Empty = derive from the request."
  type        = string
  default     = ""
}

variable "storage_volume" {
  description = "Named volume for the SQLite database, config, cache, and thumbnails (/photoprism/storage). Critical — back it up."
  type        = string
  default     = "photoprism_storage"
}

variable "originals_volume" {
  description = "Named volume for your original photos and videos (/photoprism/originals)."
  type        = string
  default     = "photoprism_originals"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources. Indexing/face recognition is memory-hungry; 4GB+ recommended."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 3072
  }
}
