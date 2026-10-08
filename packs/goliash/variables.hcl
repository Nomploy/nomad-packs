variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "goliash"
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
  description = "The Goliash server image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/pipozzz/goliash:0.5.0"
}

variable "port" {
  description = "Host port for the web UI, API and agent endpoint. Ignored when canary > 0 (a dynamic port is used so a canary can co-locate)."
  type        = number
  default     = 8070
}

variable "canary" {
  description = "Canary count for zero-downtime rolls. Requires database_url (Postgres) — on the SQLite volume path it is ignored. When > 0 the job uses a dynamic port (so the canary co-locates) and set public_url, since the service is reached via Traefik, not a fixed port. 0 = default single-alloc replace."
  type        = number
  default     = 0
}

variable "metrics_port" {
  description = "Port Goliash serves Prometheus /metrics on. When > 0, the service is tagged nomploy.metrics.port=<port> so nomploy's built-in OpenTelemetry Collector scrapes it. Goliash serves /metrics on the same port as the UI/API, so this normally equals `port`. 0 = not scraped."
  type        = number
  default     = 0
}

variable "public_url" {
  description = "The address people use, e.g. https://goliash.example.com. Sign-in links and cookies depend on it. Empty = http://<node-ip>:<port>. Browser push needs this to be an https origin (the push subject is handled by push_subject)."
  type        = string
  default     = ""
}

variable "push_subject" {
  description = "VAPID subject for browser push notifications, as a mailto: address (e.g. mailto:you@example.com). Required for push to work (an https public_url alone is not enough). Empty = mailto:<owner_email>, so push works out of the box."
  type        = string
  default     = ""
}

variable "owner_email" {
  description = "E-mail of the first owner. Until they sign in, every start logs a one-time sign-in link in the task logs."
  type        = string
  default     = "admin@example.com"
}

variable "environment" {
  description = "Environment the Nomad cluster belongs to in Goliash (e.g. prod or staging)."
  type        = string
  default     = "prod"
}

variable "watch_nomad" {
  description = "Watch the Nomad cluster this job runs on (read-only), without an agent."
  type        = bool
  default     = true
}

variable "nomad_address" {
  description = "Nomad API address for watching the cluster. Empty = http://<node-ip>:4646."
  type        = string
  default     = ""
}

variable "nomad_token" {
  description = "Nomad ACL token with the read-job capability, when ACLs are enabled. Empty = no token."
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "Key that encrypts notification channel secrets (openssl rand -base64 32). Empty = generated on the data volume on first start."
  type        = string
  default     = ""
}

variable "github_token" {
  description = "GitHub token for release notes lookups (raises GitHub's rate limit). Optional."
  type        = string
  default     = ""
}

variable "database_url" {
  description = "PostgreSQL DSN (postgres://user:pass@host:5432/db). Set this to run stateless on Postgres instead of SQLite; when set, no /data volume is mounted. Empty = SQLite on the data volume."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for the SQLite database and the secret key (/data). Ignored when database_url is set."
  type        = string
  default     = "goliash_data"
}

variable "dns_servers" {
  description = "DNS servers for the container, so it can resolve *.service.consul (e.g. a managed Postgres by its Consul name). On nomploy each server node runs a dnsmasq on its WireGuard IP that forwards *.service.consul to Consul and everything else upstream — the hub is 10.10.0.1. List all server IPs for failover, or set [] to disable (use the host resolver)."
  type        = list(string)
  default     = ["10.10.0.1"]
}

variable "constraints" {
  description = "Constraints to pin the job to the node holding the data volume."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 256
  }
}
