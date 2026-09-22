variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "qdrant"
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
  description = "The Qdrant container image. Pin a tag in production."
  type        = string
  default     = "qdrant/qdrant:latest"
}

variable "http_port" {
  description = "Host port for the REST API + web dashboard (/dashboard)."
  type        = number
  default     = 6333
}

variable "grpc_port" {
  description = "Host port for the gRPC API."
  type        = number
  default     = 6334
}

variable "api_key" {
  description = "Optional API key. Empty = open (no auth). Set it to require an api-key header on all requests."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /qdrant/storage (collections + vectors). Qdrant runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "qdrant_data"
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
  description = "The task resources. Raise memory for large collections (vectors are held in RAM by default)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
