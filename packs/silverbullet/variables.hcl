variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "silverbullet"
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
  description = "The SilverBullet container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/silverbulletmd/silverbullet:latest"
}

variable "port" {
  description = "Host port for the SilverBullet web UI."
  type        = number
  default     = 3000
}

variable "data_volume" {
  description = "Named volume mounted at /data — your Markdown space (all notes as plain files)."
  type        = string
  default     = "silverbullet_data"
}

variable "auth" {
  description = "Optional built-in auth as \"user:password\" (SB_USER). Empty = no auth (put it behind a reverse proxy). STRONGLY recommended if reachable off-LAN."
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
    cpu    = 300
    memory = 256
  }
}
