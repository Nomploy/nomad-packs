variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "fleet"
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

# --- Fleet server ---------------------------------------------------------

variable "fleet_image" {
  description = "The Fleet server container image. Pin a tag in production — Fleet runs schema migrations on start, so an unexpected major upgrade migrates your DB irreversibly."
  type        = string
  default     = "fleetdm/fleet:latest"
}

variable "port" {
  description = "Host port for Fleet's UI/API (host networking). Fleet serves plain HTTP here (TLS off) — front it with Traefik/a load balancer for TLS. Pick a free port on the target node."
  type        = number
  default     = 8080
}

variable "server_tls" {
  description = "Whether Fleet terminates TLS itself. Keep false and terminate TLS at your reverse proxy; set true only if you also supply cert/key files into the container."
  type        = bool
  default     = false
}

variable "server_private_key" {
  description = "Optional 32-byte base64 key (openssl rand -base64 32) enabling MDM features and encrypted storage of secrets. Leave empty for basic osquery fleet management. If set, it is baked into the job env — treat it as a secret."
  type        = string
  default     = ""
}

variable "fleet_resources" {
  description = "Resources for the Fleet server task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

# --- MySQL (required dependency) ------------------------------------------

variable "mysql_image" {
  description = "MySQL image. Fleet requires MySQL 8.0.x (8.0.44+ recommended)."
  type        = string
  default     = "mysql:8"
}

variable "mysql_port" {
  description = "Host port MySQL listens on. Fleet connects to it on 127.0.0.1 (same host network namespace)."
  type        = number
  default     = 3306
}

variable "mysql_database" {
  description = "Database name Fleet uses."
  type        = string
  default     = "fleet"
}

variable "mysql_username" {
  description = "Application DB user Fleet connects as."
  type        = string
  default     = "fleet"
}

variable "mysql_password" {
  description = "Password for the application DB user. CHANGE THIS."
  type        = string
  default     = "fleet"
}

variable "mysql_root_password" {
  description = "MySQL root password (used to bootstrap the instance). CHANGE THIS."
  type        = string
  default     = "fleet"
}

variable "mysql_data_volume" {
  description = "Docker named volume for /var/lib/mysql. A fresh volume inherits the image's data-dir ownership so MySQL can write it. This is the only truly critical state — back it up."
  type        = string
  default     = "fleet_mysql_data"
}

variable "mysql_resources" {
  description = "Resources for the MySQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 1024
  }
}

# --- Redis (required dependency) ------------------------------------------

variable "redis_image" {
  description = "Redis image. Fleet supports Redis 6/7."
  type        = string
  default     = "redis:7"
}

variable "redis_port" {
  description = "Host port Redis listens on. Fleet connects to it on 127.0.0.1 (same host network namespace)."
  type        = number
  default     = 6379
}

variable "redis_data_volume" {
  description = "Docker named volume for Redis /data (AOF). Redis holds only live/query state — losing it is not fatal, but persisting avoids a cold cache on reschedule."
  type        = string
  default     = "fleet_redis_data"
}

variable "redis_resources" {
  description = "Resources for the Redis task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 256
  }
}

# --- Placement ------------------------------------------------------------

variable "constraints" {
  description = "Placement constraints — pin the job to one node so the MySQL/Redis local volumes stay put (this pack runs a single all-in-one alloc). On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}
