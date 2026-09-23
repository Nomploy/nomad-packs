variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "litellm"
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
  description = "The LiteLLM proxy container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/berriai/litellm:main-latest"
}

variable "port" {
  description = "Host port for the LiteLLM OpenAI-compatible API."
  type        = number
  default     = 4000
}

variable "master_key" {
  description = "Master API key clients authenticate with (LITELLM_MASTER_KEY). Must start with 'sk-'. CHANGE THIS."
  type        = string
  default     = "sk-change-me-to-a-long-random-key"
}

variable "ollama_base" {
  description = "Base URL of an Ollama server to expose (models as ollama/<name>). Empty to omit."
  type        = string
  default     = "http://127.0.0.1:11434"
}

variable "config" {
  description = "Full LiteLLM config.yaml. The default proxies all Ollama models via ollama_base; add provider models/keys as needed."
  type        = string
  default     = <<-EOT
    model_list:
      - model_name: ollama/*
        litellm_params:
          model: ollama/*
          api_base: os.environ/OLLAMA_API_BASE
    litellm_settings:
      drop_params: true
  EOT
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
    cpu    = 500
    memory = 512
  }
}
