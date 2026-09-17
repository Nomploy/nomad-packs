variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "nats"
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
  description = "The NATS server container image."
  type        = string
  default     = "nats:2"
}

variable "client_port" {
  description = "Host port for client connections (nats:// protocol)."
  type        = number
  default     = 4222
}

variable "monitoring_port" {
  description = "Host port for the HTTP monitoring endpoint (/varz, /healthz, etc.)."
  type        = number
  default     = 8222
}

variable "jetstream" {
  description = "Enable JetStream (persistence: streams, KV, object store). When true, the data volume is mounted at /data as the store dir."
  type        = bool
  default     = true
}

variable "auth_token" {
  description = "Optional connection token. Empty = no auth (open on the trusted network). Set it and clients connect as nats://<token>@host:port."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for the JetStream store (/data). NATS runs as root, so a fresh volume is writable. Ignored when jetstream = false."
  type        = string
  default     = "nats_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the JetStream local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
