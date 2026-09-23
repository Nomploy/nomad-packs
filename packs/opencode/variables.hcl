variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "opencode"
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
  description = "The OpenCode container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/anomalyco/opencode:latest"
}

variable "port" {
  description = "Host port for the OpenCode headless HTTP server."
  type        = number
  default     = 4096
}

variable "anthropic_api_key" {
  description = "Anthropic API key (ANTHROPIC_API_KEY). Set this or another provider key."
  type        = string
  default     = ""
}

variable "openai_api_key" {
  description = "OpenAI API key (OPENAI_API_KEY). Optional."
  type        = string
  default     = ""
}

variable "config_volume" {
  description = "Named volume for OpenCode config (/root/.config/opencode)."
  type        = string
  default     = "opencode_config"
}

variable "data_volume" {
  description = "Named volume for OpenCode auth, sessions, and state (/root/.local/share/opencode)."
  type        = string
  default     = "opencode_data"
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
