variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "audiobookshelf"
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
  description = "The Audiobookshelf container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/advplyr/audiobookshelf:latest"
}

variable "port" {
  description = "Host port for the Audiobookshelf web UI (PORT)."
  type        = number
  default     = 13378
}

variable "config_volume" {
  description = "Named volume for config and the database (/config)."
  type        = string
  default     = "audiobookshelf_config"
}

variable "metadata_volume" {
  description = "Named volume for generated metadata — covers, cache (/metadata)."
  type        = string
  default     = "audiobookshelf_metadata"
}

variable "library_volume" {
  description = "Named volume for your audiobooks and podcasts library (/audiobooks). Fill it with your media."
  type        = string
  default     = "audiobookshelf_library"
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
