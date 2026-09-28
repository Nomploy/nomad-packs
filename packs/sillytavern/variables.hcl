variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "sillytavern"
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
  description = "The SillyTavern container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/sillytavern/sillytavern:latest"
}

variable "port" {
  description = "Host port for the SillyTavern web UI."
  type        = number
  default     = 8000
}

variable "basic_auth" {
  description = "Enable HTTP basic authentication (true/false). Strongly recommended if exposed."
  type        = string
  default     = "false"
}

variable "basic_auth_user" {
  description = "Basic-auth username (used when basic_auth is true)."
  type        = string
  default     = "user"
}

variable "basic_auth_password" {
  description = "Basic-auth password (used when basic_auth is true). CHANGE THIS."
  type        = string
  default     = "sillytavern_change_me"
}

variable "config_volume" {
  description = "Named volume for SillyTavern config (/home/node/app/config)."
  type        = string
  default     = "sillytavern_config"
}

variable "data_volume" {
  description = "Named volume for user data: chats, characters, settings (/home/node/app/data)."
  type        = string
  default     = "sillytavern_data"
}

variable "plugins_volume" {
  description = "Named volume for server plugins (/home/node/app/plugins)."
  type        = string
  default     = "sillytavern_plugins"
}

variable "extensions_volume" {
  description = "Named volume for third-party UI extensions."
  type        = string
  default     = "sillytavern_extensions"
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
