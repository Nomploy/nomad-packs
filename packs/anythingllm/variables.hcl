variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "anythingllm"
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
  description = "The AnythingLLM container image. Pin a tag in production."
  type        = string
  default     = "mintplexlabs/anythingllm:latest"
}

variable "port" {
  description = "Host port for the AnythingLLM web UI / API. The container listens on 3001."
  type        = number
  default     = 3001
}

variable "storage_volume" {
  description = "Named volume for AnythingLLM storage (/app/server/storage): the SQLite DB, vector cache, and documents."
  type        = string
  default     = "anythingllm_storage"
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
  description = "Resources for the AnythingLLM task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
