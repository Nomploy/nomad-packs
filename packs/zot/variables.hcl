variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "zot"
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
  description = "The zot container image. zot publishes per-arch images — use zot-linux-amd64 or zot-linux-arm64 to match the target node."
  type        = string
  default     = "ghcr.io/project-zot/zot-linux-amd64:v2.1.5"
}

variable "port" {
  description = "Host port the registry listens on (the job uses host networking, so it's reachable at <node-ip>:<port>)."
  type        = number
  default     = 5000
}

variable "count" {
  description = "Number of instances (keep at 1 for local-disk storage)."
  type        = number
  default     = 1
}

variable "data_dir" {
  description = "Host directory bind-mounted for the blob store, so images survive restarts. Pin the job (see constraints) to keep this stable."
  type        = string
  default     = "/opt/zot"
}

variable "constraints" {
  description = "Placement constraints — e.g. pin to a control-plane node so data_dir stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "anonymous_pull" {
  description = "Allow anonymous (unauthenticated) pulls. Recommended true for a registry that only listens on a private/overlay network. Only takes effect when htpasswd is set (otherwise the registry is fully open)."
  type        = bool
  default     = true
}

variable "htpasswd" {
  description = "htpasswd line(s) enabling authenticated push (user:bcrypthash). Generate with: htpasswd -bnBC10 <user> <pass>. Leave empty for a fully open registry (no auth at all)."
  type        = string
  default     = ""
}

variable "resources" {
  description = "The task resources. Raise memory if you enable CVE scanning (Trivy)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
