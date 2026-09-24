variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "littlelink"
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
  description = "The LittleLink Server container image. Pin a tag in production."
  type        = string
  default     = "timothystewart6/littlelink-server:latest"
}

variable "port" {
  description = "Host port for the page. The container listens on 3000."
  type        = number
  default     = 3000
}

variable "name" {
  description = "Display name / page title (NAME)."
  type        = string
  default     = "Your Name"
}

variable "theme" {
  description = "Color theme (THEME): auto, light, or dark."
  type        = string
  default     = "auto"
}

variable "description" {
  description = "Short bio shown under your name (DESCRIPTION)."
  type        = string
  default     = "My links"
}

variable "avatar_url" {
  description = "URL of the avatar image (AVATAR_URL). Empty = the default avatar."
  type        = string
  default     = ""
}

variable "count" {
  description = "How many instances to run. LittleLink is stateless, so you can run several."
  type        = number
  default     = 1
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
  description = "Resources for the LittleLink task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
