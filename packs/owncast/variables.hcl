variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "owncast"
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
  description = "The Owncast container image. Pin a tag in production."
  type        = string
  default     = "owncast/owncast:latest"
}

variable "port" {
  description = "Host port for the web player, chat, and admin."
  type        = number
  default     = 8080
}

variable "rtmp_port" {
  description = "Host port for RTMP ingest (point your broadcaster here)."
  type        = number
  default     = 1935
}

variable "data_volume" {
  description = "Named volume for the SQLite config, HLS segments, and logs (/app/data)."
  type        = string
  default     = "owncast_data"
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
  description = "The task resources (transcoding is CPU-heavy)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 512
  }
}
