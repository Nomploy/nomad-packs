variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "infinity"
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
  description = "The Infinity container image. Pin a tag in production."
  type        = string
  default     = "michaelf34/infinity:latest-cpu"
}

variable "port" {
  description = "Host port for the OpenAI-compatible API."
  type        = number
  default     = 7997
}

variable "model_id" {
  description = "Hugging Face model to serve (--model-id). Default is a small, fast English embedding model. Use a comma-separated list to serve several."
  type        = string
  default     = "BAAI/bge-small-en-v1.5"
}

variable "data_volume" {
  description = "Named volume mounted at /app/.cache — the Hugging Face model cache."
  type        = string
  default     = "infinity_data"
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
    cpu    = 2000
    memory = 2048
  }
}
