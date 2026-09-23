variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "shiori"
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
  description = "The Shiori container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/go-shiori/shiori:latest"
}

variable "port" {
  description = "Host port for the Shiori web UI."
  type        = number
  default     = 8105
}

variable "secret_key" {
  description = "Secret used to sign sessions (SHIORI_HTTP_SECRET_KEY). Set a long random value."
  type        = string
  default     = "change-me-to-a-long-random-secret"
}

variable "uid" {
  description = "UID Shiori runs as (the image is distroless/nonroot). The data volume is chown'd to this."
  type        = number
  default     = 65532
}

variable "data_volume" {
  description = "Named volume for the SQLite database and archived pages (/shiori)."
  type        = string
  default     = "shiori_data"
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
