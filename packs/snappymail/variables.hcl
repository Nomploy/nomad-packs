variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "snappymail"
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
  description = "The SnappyMail container image. Pin a tag in production."
  type        = string
  default     = "djmaze/snappymail:latest"
}

variable "port" {
  description = "Host port for the SnappyMail web UI. The container's nginx is fixed at 8888, so keep this at 8888 unless you also change the image config."
  type        = number
  default     = 8888
}

variable "upload_max_size" {
  description = "Maximum attachment upload size (UPLOAD_MAX_SIZE), e.g. 25M."
  type        = string
  default     = "25M"
}

variable "data_volume" {
  description = "Named volume for SnappyMail data and config (/var/lib/snappymail)."
  type        = string
  default     = "snappymail_data"
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
  description = "Resources for the SnappyMail task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
