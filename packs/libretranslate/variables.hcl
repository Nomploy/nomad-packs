variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "libretranslate"
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
  description = "The LibreTranslate container image. Pin a tag in production."
  type        = string
  default     = "libretranslate/libretranslate:latest"
}

variable "port" {
  description = "Host port for the LibreTranslate web UI / API. The container listens on 5000."
  type        = number
  default     = 5000
}

variable "load_only" {
  description = "Comma-separated language codes to load (LT_LOAD_ONLY). Fewer languages = faster startup and less disk. Empty = download all languages (large)."
  type        = string
  default     = "en,es,de,fr,sk,cs"
}

variable "api_keys_enabled" {
  description = "Require API keys for requests (LT_API_KEYS). When true, add keys with `ltmanage keys add` inside the container."
  type        = bool
  default     = false
}

variable "models_volume" {
  description = "Named volume for downloaded language models (/home/libretranslate/.local)."
  type        = string
  default     = "libretranslate_models"
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
  description = "Resources for the LibreTranslate task. Translation is CPU-bound; give it more CPU for throughput."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
