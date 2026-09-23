variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "mealie"
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
  description = "The Mealie container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/mealie-recipes/mealie:latest"
}

variable "port" {
  description = "Host port for the Mealie web UI / API. The container listens on 9000."
  type        = number
  default     = 9000
}

variable "base_url" {
  description = "Public base URL Mealie is served at (BASE_URL), e.g. https://recipes.example.com. Empty = http://localhost:<port>."
  type        = string
  default     = ""
}

variable "allow_signup" {
  description = "Allow open user self-registration (ALLOW_SIGNUP). Keep false and invite users instead."
  type        = bool
  default     = false
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
}

variable "data_volume" {
  description = "Named volume for Mealie data (/app/data): the SQLite database, recipe images, and backups."
  type        = string
  default     = "mealie_data"
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
  description = "Resources for the Mealie task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
