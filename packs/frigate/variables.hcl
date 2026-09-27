variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "frigate"
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
  description = "The Frigate container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/blakeblackshear/frigate:stable"
}

variable "port" {
  description = "Host port for the authenticated Frigate web UI."
  type        = number
  default     = 8971
}

variable "rtsp_port" {
  description = "Host port for the internal RTSP restream (go2rtc)."
  type        = number
  default     = 8554
}

variable "webrtc_port" {
  description = "Host port for WebRTC live view (TCP and UDP)."
  type        = number
  default     = 8555
}

variable "shm_size" {
  description = "Shared-memory size in bytes for camera frame buffers. Increase for many/high-res cameras."
  type        = number
  default     = 268435456
}

variable "cache_size" {
  description = "tmpfs size in bytes for /tmp/cache (recording segments)."
  type        = number
  default     = 1073741824
}

variable "config_volume" {
  description = "Named volume for the Frigate config and database (/config)."
  type        = string
  default     = "frigate_config"
}

variable "media_volume" {
  description = "Named volume for recordings and snapshots (/media/frigate)."
  type        = string
  default     = "frigate_media"
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
  description = "The task resources. Object detection is CPU-heavy without a hardware accelerator."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 2048
  }
}
