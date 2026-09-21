variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "vikunja"
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
  description = "The Vikunja (unified frontend+API) container image. Pin a tag in production."
  type        = string
  default     = "vikunja/vikunja:latest"
}

variable "port" {
  description = "Host port for Vikunja (web UI + API)."
  type        = number
  default     = 3456
}

variable "public_url" {
  description = "Public URL Vikunja is served at, e.g. https://tasks.example.com/ (trailing slash). Needed so the frontend can reach the API when behind a domain/proxy. Empty = same-origin (works for direct http://<node-ip>:<port> access)."
  type        = string
  default     = ""
}

variable "service_secret" {
  description = "Secret used to sign JWT sessions. Set a random string and keep it stable (changing it logs everyone out). Empty = Vikunja generates a new one each start."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /db (SQLite database + file uploads under /db/files). A prestart task chowns it to uid 1000 (Vikunja's user) so it can write. Back it up."
  type        = string
  default     = "vikunja_data"
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
