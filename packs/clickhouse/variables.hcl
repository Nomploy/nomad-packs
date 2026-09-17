variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "clickhouse"
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
  description = "The ClickHouse server container image."
  type        = string
  default     = "clickhouse/clickhouse-server:latest"
}

variable "http_port" {
  description = "Host port for the HTTP interface (used by most clients, BI tools, and the play UI at /play)."
  type        = number
  default     = 8123
}

variable "tcp_port" {
  description = "Host port for the native TCP protocol (clickhouse-client, native drivers)."
  type        = number
  default     = 9000
}

variable "db_name" {
  description = "Database created on first boot."
  type        = string
  default     = "default"
}

variable "db_user" {
  description = "User created on first boot."
  type        = string
  default     = "default"
}

variable "db_password" {
  description = "Password for db_user. CHANGE THIS — empty means no password. Only applied on first boot."
  type        = string
  default     = "clickhouse"
}

variable "data_volume" {
  description = "Docker named volume for /var/lib/clickhouse. The image's entrypoint fixes ownership on start, so a fresh volume works. Back it up."
  type        = string
  default     = "clickhouse_data"
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
  description = "The task resources. ClickHouse likes memory — raise for real workloads."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
  }
}
