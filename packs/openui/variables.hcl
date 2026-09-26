variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "openui"
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
  description = "The OpenUI container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/wandb/openui:latest"
}

variable "port" {
  description = "Host port for the OpenUI web UI. Fixed at 7878 inside the image."
  type        = number
  default     = 7878
}

variable "ollama_host" {
  description = "URL of an Ollama server to use for local models (OLLAMA_HOST). On a nomploy node with the ollama pack, the default loopback works."
  type        = string
  default     = "http://127.0.0.1:11434"
}

variable "openai_api_key" {
  description = "Optional OpenAI API key (OPENAI_API_KEY) to enable OpenAI models. Leave empty to use only Ollama / other providers set via env."
  type        = string
  default     = ""
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
    cpu    = 300
    memory = 256
  }
}
