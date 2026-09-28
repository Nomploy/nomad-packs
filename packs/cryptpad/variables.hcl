variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "cryptpad"
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
  description = "The CryptPad container image. Pin a tag in production."
  type        = string
  default     = "cryptpad/cryptpad:latest"
}

variable "port" {
  description = "Host port for the CryptPad main application."
  type        = number
  default     = 3000
}

variable "sandbox_port" {
  description = "Host port for the CryptPad sandbox (must be a different origin from the main port)."
  type        = number
  default     = 3001
}

variable "main_domain" {
  description = "Public URL of the main app (e.g. https://cryptpad.example.com). Must differ from the sandbox domain."
  type        = string
  default     = "http://localhost:3000"
}

variable "sandbox_domain" {
  description = "Public URL of the sandbox (e.g. https://sandbox.example.com). Must be a DIFFERENT origin from main_domain."
  type        = string
  default     = "http://localhost:3001"
}

variable "data_volume" {
  description = "Named volume for encrypted document data (/cryptpad/data)."
  type        = string
  default     = "cryptpad_data"
}

variable "blob_volume" {
  description = "Named volume for uploaded encrypted blobs (/cryptpad/blob)."
  type        = string
  default     = "cryptpad_blob"
}

variable "block_volume" {
  description = "Named volume for login blocks (/cryptpad/block)."
  type        = string
  default     = "cryptpad_block"
}

variable "datastore_volume" {
  description = "Named volume for the channel datastore (/cryptpad/datastore)."
  type        = string
  default     = "cryptpad_datastore"
}

variable "customize_volume" {
  description = "Named volume for customization/theming (/cryptpad/customize)."
  type        = string
  default     = "cryptpad_customize"
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
    cpu    = 1000
    memory = 1024
  }
}
