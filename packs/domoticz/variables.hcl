variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "domoticz"
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
  description = "The Domoticz container image. Pin a tag in production."
  type        = string
  default     = "domoticz/domoticz:stable"
}

variable "port" {
  description = "Host port for the Domoticz web UI (HTTP)."
  type        = number
  default     = 8080
}

variable "https_port" {
  description = "Host port for the Domoticz web UI (HTTPS)."
  type        = number
  default     = 8443
}

variable "data_volume" {
  description = "Named volume for the Domoticz database and config (/opt/domoticz/userdata)."
  type        = string
  default     = "domoticz_userdata"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\". Pin to the node on your device LAN."
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
    cpu    = 500
    memory = 512
  }
}
