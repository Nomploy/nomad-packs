variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "teamspeak"
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
  description = "The TeamSpeak 3 server image. Pin a tag in production."
  type        = string
  default     = "teamspeak:latest"
}

variable "voice_port" {
  description = "Host UDP port for voice communication."
  type        = number
  default     = 9987
}

variable "query_port" {
  description = "Host TCP port for the ServerQuery admin interface."
  type        = number
  default     = 10011
}

variable "filetransfer_port" {
  description = "Host TCP port for file transfers."
  type        = number
  default     = 30033
}

variable "data_volume" {
  description = "Named volume for TeamSpeak data (/var/ts3server): the database, config, and files."
  type        = string
  default     = "teamspeak_data"
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
  description = "Resources for the TeamSpeak task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
