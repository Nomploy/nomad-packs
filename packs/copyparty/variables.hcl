variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "copyparty"
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
  description = "The copyparty container image (ac = all codecs; use copyparty/min for a smaller image). Pin a tag in production."
  type        = string
  default     = "copyparty/ac:latest"
}

variable "port" {
  description = "Host port for the copyparty web server."
  type        = number
  default     = 3923
}

variable "share_mode" {
  description = "Anonymous access to the shared volume: 'r' (read-only), 'rw' (read+write), 'w' (upload-only), or 'g' (get-only, no listing). Add named accounts via the config volume for finer control."
  type        = string
  default     = "r"
}

variable "data_volume" {
  description = "Named volume for the shared files (/w)."
  type        = string
  default     = "copyparty_data"
}

variable "config_volume" {
  description = "Named volume for copyparty config (/cfg): drop .conf files here to define accounts and volumes."
  type        = string
  default     = "copyparty_config"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the copyparty task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
