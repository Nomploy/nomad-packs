variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "filebrowser"
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
  description = "The File Browser container image. Pin a tag in production."
  type        = string
  default     = "filebrowser/filebrowser:latest"
}

variable "port" {
  description = "Host port for the File Browser web UI (FB_PORT)."
  type        = number
  default     = 8103
}

variable "files_volume" {
  description = "Named volume for the files being managed, mounted at /srv."
  type        = string
  default     = "filebrowser_files"
}

variable "data_volume" {
  description = "Named volume for the File Browser database (/database/filebrowser.db lives here)."
  type        = string
  default     = "filebrowser_data"
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
    cpu    = 300
    memory = 128
  }
}
