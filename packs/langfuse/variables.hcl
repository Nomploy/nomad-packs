variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "langfuse"
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
  description = "The Langfuse web image."
  type        = string
  default     = "docker.langfuse.com/langfuse/langfuse:4"
}

variable "worker_image" {
  description = "The Langfuse worker image. Keep its tag in sync with the web image."
  type        = string
  default     = "docker.langfuse.com/langfuse/langfuse-worker:4"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:17"
}

variable "clickhouse_image" {
  description = "The ClickHouse image for the bundled OLAP store."
  type        = string
  default     = "clickhouse/clickhouse-server:25.12"
}

variable "redis_image" {
  description = "The Redis image for the bundled cache/queue."
  type        = string
  default     = "redis:7"
}

variable "minio_image" {
  description = "The MinIO image for the bundled S3-compatible blob store. Uses the publicly pullable Chainguard build (the minio/minio Docker Hub image now requires authentication)."
  type        = string
  default     = "cgr.dev/chainguard/minio:latest"
}

variable "port" {
  description = "Host port for the Langfuse web UI / API."
  type        = number
  default     = 3000
}

variable "worker_port" {
  description = "Host port for the Langfuse worker (loopback only)."
  type        = number
  default     = 3030
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL (loopback only)."
  type        = number
  default     = 5432
}

variable "clickhouse_http_port" {
  description = "Host port for the bundled ClickHouse HTTP interface (loopback only)."
  type        = number
  default     = 8123
}

variable "clickhouse_native_port" {
  description = "Host port for the bundled ClickHouse native protocol (loopback only)."
  type        = number
  default     = 9000
}

variable "redis_port" {
  description = "Host port for the bundled Redis (loopback only)."
  type        = number
  default     = 6379
}

variable "minio_port" {
  description = "Host port for the bundled MinIO S3 API (loopback only)."
  type        = number
  default     = 9100
}

variable "minio_console_port" {
  description = "Host port for the bundled MinIO web console (loopback only)."
  type        = number
  default     = 9101
}

variable "nextauth_url" {
  description = "Public URL of this Langfuse instance (used for auth callbacks and links)."
  type        = string
  default     = "http://localhost:3000"
}

variable "nextauth_secret" {
  description = "Secret used to sign auth sessions (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_nextauth_secret_to_a_long_random_value"
}

variable "salt" {
  description = "Salt for hashing API keys (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_salt_to_a_long_random_value"
}

variable "encryption_key" {
  description = "32-byte key as 64 hex chars (openssl rand -hex 32), encrypts stored secrets. CHANGE THIS and keep it stable."
  type        = string
  default     = "0000000000000000000000000000000000000000000000000000000000000000"
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "langfuse_change_me"
}

variable "clickhouse_password" {
  description = "Password for the bundled ClickHouse. CHANGE THIS."
  type        = string
  default     = "clickhouse_change_me"
}

variable "redis_password" {
  description = "Password (requirepass) for the bundled Redis. CHANGE THIS."
  type        = string
  default     = "redis_change_me"
}

variable "minio_root_password" {
  description = "Root password for the bundled MinIO. CHANGE THIS."
  type        = string
  default     = "minio_change_me"
}

variable "s3_public_endpoint" {
  description = "Browser-reachable URL of the bundled MinIO S3 API, used to sign media URLs. Set to a public URL (e.g. https://s3.example.com) when exposing media; defaults to the loopback API port."
  type        = string
  default     = "http://localhost:9100"
}

variable "telemetry_enabled" {
  description = "Whether Langfuse sends anonymous usage telemetry to the project."
  type        = string
  default     = "true"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "langfuse_db_data"
}

variable "clickhouse_data_volume" {
  description = "Named volume for ClickHouse data."
  type        = string
  default     = "langfuse_clickhouse_data"
}

variable "minio_data_volume" {
  description = "Named volume for MinIO blob data."
  type        = string
  default     = "langfuse_minio_data"
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
  description = "Resources for the Langfuse web task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1536
  }
}

variable "worker_resources" {
  description = "Resources for the Langfuse worker task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1536
  }
}

variable "db_resources" {
  description = "Resources for the bundled PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "clickhouse_resources" {
  description = "Resources for the bundled ClickHouse task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 3072
  }
}

variable "redis_resources" {
  description = "Resources for the bundled Redis task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 256
  }
}

variable "minio_resources" {
  description = "Resources for the bundled MinIO task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 512
  }
}
