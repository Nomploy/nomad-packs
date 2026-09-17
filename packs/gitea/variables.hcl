variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "gitea"
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
  description = "The Gitea container image."
  type        = string
  default     = "gitea/gitea:1"
}

variable "http_port" {
  description = "Host port for the Gitea web UI / HTTP git. Default 3002 to avoid the nomploy panel (:3000) and grafana (:3001)."
  type        = number
  default     = 3002
}

variable "ssh_port" {
  description = "Host port for git-over-SSH. Gitea both listens on this and advertises it in SSH clone URLs. Avoid 22 (usually the host's own sshd)."
  type        = number
  default     = 2222
}

variable "root_url" {
  description = "Public base URL Gitea is served at (e.g. https://git.example.com/), used to build HTTP clone links and webhooks. Empty = Gitea derives it from the request host."
  type        = string
  default     = ""
}

variable "ssh_domain" {
  description = "Hostname advertised in SSH clone URLs (e.g. git.example.com). Empty = Gitea uses the request host."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /data (repositories, SQLite DB, config, LFS). All of Gitea's state — back it up. Gitea's entrypoint fixes ownership on start, so a fresh volume works."
  type        = string
  default     = "gitea_data"
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
