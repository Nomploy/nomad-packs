variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "minio"
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
  description = "The MinIO container image. Pin a tag in production."
  type        = string
  default     = "minio/minio:latest"
}

variable "port" {
  description = "Host port for the S3 API (--address)."
  type        = number
  default     = 9000
}

variable "console_port" {
  description = "Host port for the web console (--console-address)."
  type        = number
  default     = 9001
}

variable "root_user" {
  description = "Root access key (MINIO_ROOT_USER). Must be at least 3 characters."
  type        = string
  default     = "minioadmin"
}

variable "root_password" {
  description = "Root secret key (MINIO_ROOT_PASSWORD). CHANGE THIS — must be at least 8 characters."
  type        = string
  default     = "change-me-min-8-chars"
}

variable "data_volume" {
  description = "Named volume for object data (/data). Holds all buckets and objects."
  type        = string
  default     = "minio_data"
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
  description = "Resources for the MinIO task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
