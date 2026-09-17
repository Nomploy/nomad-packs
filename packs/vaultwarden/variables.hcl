variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "vaultwarden"
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
  description = "The Vaultwarden container image."
  type        = string
  default     = "vaultwarden/server:latest"
}

variable "port" {
  description = "Host port for the Vaultwarden web vault / API. Default 8280 (avoids 8222 used by the nats pack's monitoring)."
  type        = number
  default     = 8280
}

variable "domain" {
  description = "Public URL Vaultwarden is served at (e.g. https://vault.example.com). STRONGLY recommended — WebAuthn/U2F, some clients, and the admin page need it correct. Empty = leave unset (works for basic LAN use over the IP)."
  type        = string
  default     = ""
}

variable "signups_allowed" {
  description = "Allow open user registration. Set false once your users have signed up (or use invitations from the admin page)."
  type        = bool
  default     = true
}

variable "admin_token" {
  description = "Argon2/plain token guarding the /admin page. Empty = admin page DISABLED (recommended unless you need it). If set, treat it as a secret."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /data (SQLite DB, RSA keys, attachments, icon cache). All of Vaultwarden's state — BACK IT UP. Vaultwarden runs as root, so a fresh volume is writable."
  type        = string
  default     = "vaultwarden_data"
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
