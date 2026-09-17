variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "grafana"
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
  description = "The Grafana container image."
  type        = string
  default     = "grafana/grafana:latest"
}

variable "port" {
  description = "Host port Grafana listens on (host networking). Default 3001 to avoid clashing with the nomploy panel on :3000. Pick a free port on the target node."
  type        = number
  default     = 3001
}

variable "count" {
  description = "Number of instances (keep at 1 — the default SQLite DB is local-disk)."
  type        = number
  default     = 1
}

variable "admin_user" {
  description = "Initial admin username."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Initial admin password. CHANGE THIS — it is baked into the job env."
  type        = string
  default     = "admin"
}

variable "root_url" {
  description = "Public URL Grafana believes it is served at (set when fronting it with a domain, e.g. https://grafana.example.com). Empty = use the host:port."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /var/lib/grafana (SQLite DB, plugins). A fresh volume inherits the image's dir ownership (uid 472), so Grafana can write it."
  type        = string
  default     = "grafana_data"
}

variable "constraints" {
  description = "Placement constraints — e.g. pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
