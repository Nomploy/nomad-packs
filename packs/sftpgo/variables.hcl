variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "sftpgo"
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
  description = "The SFTPGo container image. Pin a tag in production."
  type        = string
  default     = "drakkan/sftpgo:latest"
}

variable "port" {
  description = "Host port for the SFTPGo web admin / client UI (HTTP)."
  type        = number
  default     = 8080
}

variable "sftp_port" {
  description = "Host port for the SFTP service."
  type        = number
  default     = 2022
}

variable "data_volume" {
  description = "Named volume mounted at /srv/sftpgo — persistent data and user home directories (data/<username>)."
  type        = string
  default     = "sftpgo_data"
}

variable "home_volume" {
  description = "Named volume mounted at /var/lib/sftpgo — the SFTPGo config, SQLite database and host keys."
  type        = string
  default     = "sftpgo_home"
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
