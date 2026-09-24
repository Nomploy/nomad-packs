variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "siyuan"
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
  description = "The SiYuan container image. Pin a tag in production."
  type        = string
  default     = "b3log/siyuan:latest"
}

variable "port" {
  description = "Host port for the SiYuan web UI. The container listens on 6806."
  type        = number
  default     = 6806
}

variable "access_auth_code" {
  description = "Access (lock-screen) password required to open the workspace (--accessAuthCode). CHANGE THIS — anyone with it can read/write your notes."
  type        = string
  default     = "change-me-please"
}

variable "workspace_volume" {
  description = "Named volume for the SiYuan workspace (/siyuan/workspace): all notes, assets, and settings."
  type        = string
  default     = "siyuan_workspace"
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
  description = "Resources for the SiYuan task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
