variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "archivebox"
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
  description = "The ArchiveBox container image. Pin a tag in production."
  type        = string
  default     = "archivebox/archivebox:latest"
}

variable "port" {
  description = "Host port for the ArchiveBox web UI."
  type        = number
  default     = 8000
}

variable "admin_user" {
  description = "Admin username created on first start."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Admin password created on first start. CHANGE THIS."
  type        = string
  default     = "archivebox_change_me"
}

variable "csrf_trusted_origins" {
  description = "Comma-separated origins allowed to submit the admin login form (set to your public URL)."
  type        = string
  default     = "http://localhost:8000"
}

variable "data_volume" {
  description = "Named volume for the archive, index and config (/data)."
  type        = string
  default     = "archivebox_data"
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
  description = "The task resources. Archiving (headless Chrome) benefits from more memory."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
  }
}
