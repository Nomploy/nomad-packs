variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "scrutiny"
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
  description = "The Scrutiny container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/analogj/scrutiny:master-omnibus"
}

variable "port" {
  description = "Host port for the Scrutiny web UI."
  type        = number
  default     = 8080
}

variable "data_volume" {
  description = "Named volume mounted at /opt/scrutiny/config."
  type        = string
  default     = "scrutiny_data"
}

variable "influx_volume" {
  description = "Named volume mounted at /opt/scrutiny/influxdb — the time-series history store (omnibus InfluxDB)."
  type        = string
  default     = "scrutiny_influxdb"
}

variable "disks" {
  description = "Host disk device paths to monitor for S.M.A.R.T. health, e.g. [\"/dev/sda\", \"/dev/nvme0\"]. List your real devices (see: lsblk -d). Each is passed through to the collector."
  type        = list(string)
  default     = ["/dev/sda"]
}

variable "cap_add" {
  description = "Linux capabilities the collector needs to issue S.M.A.R.T. commands. SYS_RAWIO covers SATA/SAS; SYS_ADMIN is required for many NVMe drives."
  type        = list(string)
  default     = ["SYS_RAWIO", "SYS_ADMIN"]
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
