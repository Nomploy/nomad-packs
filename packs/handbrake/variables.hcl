variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "handbrake"
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
  description = "The HandBrake container image. Pin a tag in production."
  type        = string
  default     = "jlesage/handbrake:latest"
}

variable "port" {
  description = "Host port for the browser-streamed GUI (WEB_LISTENING_PORT)."
  type        = number
  default     = 5800
}

variable "data_volume" {
  description = "Named volume mounted at /config (application settings)."
  type        = string
  default     = "handbrake_data"
}

variable "storage_volume" {
  description = "Named volume mounted at /storage — source media to pick from in the GUI."
  type        = string
  default     = "handbrake_storage"
}

variable "watch_volume" {
  description = "Named volume mounted at /watch — drop files here for automatic conversion."
  type        = string
  default     = "handbrake_watch"
}

variable "output_volume" {
  description = "Named volume mounted at /output — converted files."
  type        = string
  default     = "handbrake_output"
}

variable "user_id" {
  description = "User ID that owns the files (USER_ID)."
  type        = number
  default     = 1000
}

variable "group_id" {
  description = "Group ID that owns the files (GROUP_ID)."
  type        = number
  default     = 1000
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
}

variable "automated_conversion" {
  description = "Enable the watch-folder automatic converter (AUTOMATED_CONVERSION): 1 on, 0 off."
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 4000
    memory = 2048
  }
}
