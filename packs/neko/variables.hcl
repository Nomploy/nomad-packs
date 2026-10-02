variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "neko"
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
  description = "The neko container image (one per browser/app, e.g. .../firefox, .../chromium, .../vlc). Pin a tag in production."
  type        = string
  default     = "ghcr.io/m1k1o/neko/firefox:latest"
}

variable "port" {
  description = "Host port for the neko web UI."
  type        = number
  default     = 8080
}

variable "webrtc_epr" {
  description = "WebRTC ephemeral UDP port range (inclusive) for media. Opened on the host via host networking."
  type        = string
  default     = "56000-56100"
}

variable "nat1to1_ip" {
  description = "Public IP clients use to reach this node for WebRTC (NAT 1:1). Empty = neko auto-detects (works on a directly-reachable host)."
  type        = string
  default     = ""
}

variable "user_password" {
  description = "Password for regular (viewer/control) members. CHANGE THIS."
  type        = string
  default     = "neko"
}

variable "admin_password" {
  description = "Password for admin members. CHANGE THIS."
  type        = string
  default     = "admin"
}

variable "screen" {
  description = "Virtual screen resolution and refresh rate."
  type        = string
  default     = "1280x720@30"
}

variable "shm_size" {
  description = "Shared-memory size in bytes for the browser (prevents renderer crashes)."
  type        = number
  default     = 2147483648
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources. A live browser needs real CPU/RAM."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 2048
  }
}
