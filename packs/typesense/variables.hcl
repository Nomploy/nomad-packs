variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "typesense"
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
  description = "The Typesense container image. Pin a tag in production."
  type        = string
  default     = "typesense/typesense:27.1"
}

variable "port" {
  description = "Host port for the Typesense HTTP API."
  type        = number
  default     = 8108
}

variable "api_key" {
  description = "Admin API key — required. CHANGE THIS; clients send it in the X-TYPESENSE-API-KEY header."
  type        = string
  default     = "changeme"
}

variable "data_volume" {
  description = "Docker named volume for /data (the search index). Typesense runs as root, so a fresh volume is writable. Back it up (or re-index)."
  type        = string
  default     = "typesense_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources. Typesense keeps indexes in memory — raise for large datasets."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
