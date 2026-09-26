variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dumbdrop"
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
  description = "The DumbDrop container image. Pin a tag in production."
  type        = string
  default     = "dumbwareio/dumbdrop:latest"
}

variable "port" {
  description = "Host port for the DumbDrop web UI."
  type        = number
  default     = 3000
}

variable "data_volume" {
  description = "Named volume mounted at /app/uploads (uploaded files)."
  type        = string
  default     = "dumbdrop_data"
}

variable "pin" {
  description = "Optional PIN protection, 4-10 digits (DUMBDROP_PIN). Empty = no auth."
  type        = string
  default     = ""
}

variable "base_url" {
  description = "Public URL DumbDrop is reachable at (BASE_URL). MUST end with a trailing slash. Empty = http://localhost:<port>/."
  type        = string
  default     = ""
}

variable "max_file_size" {
  description = "Maximum upload size in MB (MAX_FILE_SIZE)."
  type        = number
  default     = 1024
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
