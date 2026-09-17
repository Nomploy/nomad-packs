variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "monitoring"
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

# --- Images ---------------------------------------------------------------

variable "prometheus_image" {
  description = "Prometheus image. Pin a tag in production."
  type        = string
  default     = "prom/prometheus:latest"
}

variable "grafana_image" {
  description = "Grafana image."
  type        = string
  default     = "grafana/grafana:latest"
}

variable "node_exporter_image" {
  description = "Prometheus node-exporter image (host-level metrics)."
  type        = string
  default     = "prom/node-exporter:latest"
}

variable "cadvisor_image" {
  description = "cAdvisor image (per-container metrics)."
  type        = string
  default     = "gcr.io/cadvisor/cadvisor:latest"
}

# --- Ports (all on the host — pick free ones) -----------------------------

variable "prometheus_port" {
  description = "Host port for the Prometheus UI/API."
  type        = number
  default     = 9090
}

variable "grafana_port" {
  description = "Host port for Grafana. Default 3001 to avoid clashing with the nomploy panel on :3000."
  type        = number
  default     = 3001
}

variable "node_exporter_port" {
  description = "Host port node-exporter listens on."
  type        = number
  default     = 9100
}

variable "cadvisor_port" {
  description = "Host port cAdvisor listens on. Default 8082 to avoid the common 8080 clash."
  type        = number
  default     = 8082
}

# --- Prometheus -----------------------------------------------------------

variable "scrape_interval" {
  description = "Global Prometheus scrape interval."
  type        = string
  default     = "15s"
}

variable "retention" {
  description = "Prometheus TSDB retention (e.g. 15d, 30d, 90d)."
  type        = string
  default     = "15d"
}

variable "nomad_metrics_url" {
  description = "Optional extra scrape target for Nomad's own metrics, as host:port (e.g. \"127.0.0.1:4646\"). Requires Nomad telemetry with prometheus_metrics enabled. Empty = don't scrape Nomad."
  type        = string
  default     = ""
}

variable "prometheus_data_volume" {
  description = "Docker named volume for Prometheus TSDB (/prometheus). A fresh volume inherits the image's dir ownership (uid 65534) so Prometheus can write it."
  type        = string
  default     = "monitoring_prometheus_data"
}

# --- cAdvisor -------------------------------------------------------------

variable "enable_cadvisor" {
  description = "Run cAdvisor for per-container metrics. Set false if you only want host metrics, or if cAdvisor won't start on your kernel — Prometheus + node-exporter + Grafana still come up."
  type        = bool
  default     = true
}

# --- Grafana --------------------------------------------------------------

variable "grafana_admin_user" {
  description = "Initial Grafana admin username."
  type        = string
  default     = "admin"
}

variable "grafana_admin_password" {
  description = "Initial Grafana admin password. CHANGE THIS."
  type        = string
  default     = "admin"
}

variable "grafana_root_url" {
  description = "Public URL Grafana is served at (set when fronting it with a domain). Empty = use host:port."
  type        = string
  default     = ""
}

variable "grafana_data_volume" {
  description = "Docker named volume for /var/lib/grafana (SQLite DB, plugins; uid 472)."
  type        = string
  default     = "monitoring_grafana_data"
}

# --- Placement & resources ------------------------------------------------

variable "constraints" {
  description = "Placement constraints — pin the job to one node so the Prometheus/Grafana local volumes stay put (single all-in-one alloc). Note: metrics reflect the node the alloc lands on. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "prometheus_resources" {
  description = "Resources for the Prometheus task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "grafana_resources" {
  description = "Resources for the Grafana task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "exporter_resources" {
  description = "Resources for each exporter task (node-exporter, cAdvisor)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 100
    memory = 128
  }
}
