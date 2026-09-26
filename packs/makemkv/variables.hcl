variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "makemkv"
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
  description = "The MakeMKV container image. Pin a tag in production."
  type        = string
  default     = "jlesage/makemkv:latest"
}

variable "port" {
  description = "Host port for the browser-streamed GUI (WEB_LISTENING_PORT)."
  type        = number
  default     = 5800
}

variable "data_volume" {
  description = "Named volume mounted at /config (settings)."
  type        = string
  default     = "makemkv_data"
}

variable "output_volume" {
  description = "Named volume mounted at /output — ripped MKV files."
  type        = string
  default     = "makemkv_output"
}

variable "devices" {
  description = "Optical drive device paths to pass through, e.g. [\"/dev/sr0\", \"/dev/sg2\"]. SET THIS to your host's drive(s) — MakeMKV can't rip without them. Find them with: lsscsi -g."
  type        = list(string)
  default     = []
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
