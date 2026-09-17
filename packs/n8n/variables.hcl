variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "n8n"
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
  description = "The n8n container image."
  type        = string
  default     = "n8nio/n8n:latest"
}

variable "port" {
  description = "Host port for the n8n editor / webhook listener."
  type        = number
  default     = 5678
}

variable "host" {
  description = "Public hostname n8n is served at (e.g. n8n.example.com), used in generated URLs. Empty = derive from the request."
  type        = string
  default     = ""
}

variable "webhook_url" {
  description = "Public base URL for webhooks (e.g. https://n8n.example.com/). Set this when fronting n8n with a domain, or externally-triggered webhooks won't route. Empty = use host:port."
  type        = string
  default     = ""
}

variable "encryption_key" {
  description = "Key used to encrypt stored credentials. Leave empty and n8n generates one and persists it in the data volume (fine for single-node). Set it explicitly if you need to restore credentials onto a fresh volume — and treat it as a secret."
  type        = string
  default     = ""
}

variable "timezone" {
  description = "Default timezone for schedules (e.g. Europe/Bratislava)."
  type        = string
  default     = "UTC"
}

variable "secure_cookie" {
  description = "Require the n8n session cookie to be HTTPS-only. Keep false to log in over plain http://<ip>:<port>; set true when serving n8n over HTTPS (e.g. behind a TLS proxy)."
  type        = bool
  default     = false
}

variable "data_volume" {
  description = "Docker named volume for /home/node/.n8n (SQLite DB, encryption key, config). A prestart task chowns it to uid 1000 (the `node` user) so n8n can write it."
  type        = string
  default     = "n8n_data"
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
    cpu    = 500
    memory = 512
  }
}
