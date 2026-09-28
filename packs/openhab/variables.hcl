variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "openhab"
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
  description = "The openHAB container image. Pin a tag in production."
  type        = string
  default     = "openhab/openhab:latest"
}

variable "port" {
  description = "Host port for the openHAB web UI (HTTP)."
  type        = number
  default     = 8080
}

variable "https_port" {
  description = "Host port for the openHAB web UI (HTTPS)."
  type        = number
  default     = 8443
}

variable "timezone" {
  description = "Timezone for the container (e.g. Europe/Bratislava)."
  type        = string
  default     = "UTC"
}

variable "conf_volume" {
  description = "Named volume for openHAB configuration (/openhab/conf)."
  type        = string
  default     = "openhab_conf"
}

variable "userdata_volume" {
  description = "Named volume for openHAB userdata / database (/openhab/userdata)."
  type        = string
  default     = "openhab_userdata"
}

variable "addons_volume" {
  description = "Named volume for manually installed add-ons (/openhab/addons)."
  type        = string
  default     = "openhab_addons"
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
    cpu    = 1000
    memory = 1024
  }
}
