variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "fileflows"
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
  description = "The FileFlows container image. Pin a tag in production."
  type        = string
  default     = "revenz/fileflows:latest"
}

variable "port" {
  description = "Host port for the FileFlows web UI."
  type        = number
  default     = 5000
}

variable "data_volume" {
  description = "Named volume for FileFlows config, database and logs (/app/Data)."
  type        = string
  default     = "fileflows_data"
}

variable "media_volume" {
  description = "Named volume for the media library FileFlows processes (/media)."
  type        = string
  default     = "fileflows_media"
}

variable "temp_volume" {
  description = "Named volume for temporary processing files (/temp)."
  type        = string
  default     = "fileflows_temp"
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
  description = "The task resources. Transcoding is CPU-heavy."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 2048
  }
}
