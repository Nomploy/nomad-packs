variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "hermes"
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
  description = "The Hermes Agent container image. Pin a tag in production."
  type        = string
  default     = "nousresearch/hermes-agent:latest"
}

variable "port" {
  description = "Host port for the gateway's OpenAI-compatible API and health endpoint."
  type        = number
  default     = 8642
}

variable "openai_api_key" {
  description = "OpenAI API key (OPENAI_API_KEY). Set this or anthropic_api_key (or openai_base_url for a local endpoint)."
  type        = string
  default     = ""
}

variable "anthropic_api_key" {
  description = "Anthropic API key (ANTHROPIC_API_KEY). Optional."
  type        = string
  default     = ""
}

variable "openai_base_url" {
  description = "Override the OpenAI-compatible base URL (OPENAI_BASE_URL) to use a local provider, e.g. the litellm pack (http://127.0.0.1:4000/v1) or ollama. Empty = OpenAI."
  type        = string
  default     = ""
}

variable "auth_token" {
  description = "Token that secures the API endpoint (HERMES_AUTH_TOKEN). Empty = no auth (trusted network only)."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for Hermes' persistent memory, config, and keys (/opt/data)."
  type        = string
  default     = "hermes_data"
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
