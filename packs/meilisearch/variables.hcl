variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "meilisearch"
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
  description = "The Meilisearch container image. Pin a tag in production."
  type        = string
  default     = "getmeili/meilisearch:latest"
}

variable "port" {
  description = "Host port for the Meilisearch HTTP API."
  type        = number
  default     = 7700
}

variable "master_key" {
  description = "Master API key. Set it (>= 16 bytes) to run in production mode with authentication. Leave empty to run in development mode — OPEN, no auth (fine only on a trusted network). Baked into the job env; treat it as a secret."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /meili_data (the search database). Meilisearch runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "meilisearch_data"
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
  description = "The task resources. Raise memory for large indexes."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
