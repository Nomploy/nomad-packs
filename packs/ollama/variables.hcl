variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ollama"
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
  description = "The Ollama container image. Pin a tag in production."
  type        = string
  default     = "ollama/ollama:latest"
}

variable "port" {
  description = "Host port for the Ollama REST API."
  type        = number
  default     = 11434
}

variable "data_volume" {
  description = "Docker named volume for /root/.ollama (downloaded models — these can be many GB). Ollama runs as root, so a fresh volume is writable. Back it up (or just re-pull models)."
  type        = string
  default     = "ollama_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local model volume stays put (and so you land on a node with enough RAM/CPU or a GPU). On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources. LLMs are hungry — raise cpu/memory substantially for real models (7B+ needs several GB of RAM on CPU)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 4096
  }
}
