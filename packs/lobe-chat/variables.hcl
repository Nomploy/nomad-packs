variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "lobe-chat"
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
  description = "The Lobe Chat container image. Pin a tag in production."
  type        = string
  default     = "lobehub/lobe-chat:latest"
}

variable "port" {
  description = "Host port for the Lobe Chat web UI (PORT)."
  type        = number
  default     = 3210
}

variable "ollama_proxy_url" {
  description = "OpenAI-compatible Ollama endpoint (OLLAMA_PROXY_URL). Defaults to the co-located ollama pack. Empty to disable."
  type        = string
  default     = "http://127.0.0.1:11434/v1"
}

variable "openai_api_key" {
  description = "Optional OpenAI API key (OPENAI_API_KEY)."
  type        = string
  default     = ""
}

variable "access_code" {
  description = "Optional password gate for the app (ACCESS_CODE). Empty = no gate."
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
    cpu    = 500
    memory = 512
  }
}
