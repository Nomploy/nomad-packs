variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "khoj"
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
  description = "The Khoj server image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/khoj-ai/khoj:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL + pgvector image for the bundled database (Khoj needs the vector extension)."
  type        = string
  default     = "pgvector/pgvector:pg15"
}

variable "port" {
  description = "Host port for the Khoj web UI / API."
  type        = number
  default     = 42110
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL (loopback only)."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "khoj_change_me"
}

variable "django_secret_key" {
  description = "Django secret key used to sign sessions (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_django_secret_to_a_long_random_value"
}

variable "admin_email" {
  description = "Email for the initial Khoj admin account."
  type        = string
  default     = "admin@example.com"
}

variable "admin_password" {
  description = "Password for the initial Khoj admin account. CHANGE THIS."
  type        = string
  default     = "khoj_admin_change_me"
}

variable "searxng_url" {
  description = "Optional SearXNG base URL for web search (e.g. http://127.0.0.1:8888). Leave blank to disable web search. Deploy the searxng pack separately on its own port."
  type        = string
  default     = ""
}

variable "terrarium_url" {
  description = "Optional Terrarium URL for the code-execution sandbox. Leave blank to disable. See the Khoj docs to run ghcr.io/khoj-ai/terrarium separately."
  type        = string
  default     = ""
}

variable "config_volume" {
  description = "Named volume for Khoj config and index."
  type        = string
  default     = "khoj_config"
}

variable "models_volume" {
  description = "Named volume for downloaded embedding models (torch / huggingface caches)."
  type        = string
  default     = "khoj_models"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "khoj_db_data"
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
  description = "Resources for the Khoj server task (needs room for embedding models)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
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
