variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "postgrest"
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
  description = "The PostgREST container image. Pin a tag in production."
  type        = string
  default     = "postgrest/postgrest:latest"
}

variable "port" {
  description = "Host port for the REST API (PGRST_SERVER_PORT)."
  type        = number
  default     = 3027
}

variable "db_uri" {
  description = "PostgreSQL connection URI (PGRST_DB_URI). Point at your database with an authenticator role, e.g. postgres://authenticator:PASS@127.0.0.1:5432/app."
  type        = string
  default     = "postgres://authenticator:change-me@127.0.0.1:5432/postgres"
}

variable "db_schema" {
  description = "Database schema(s) to expose (PGRST_DB_SCHEMAS)."
  type        = string
  default     = "public"
}

variable "db_anon_role" {
  description = "Role used for unauthenticated requests (PGRST_DB_ANON_ROLE)."
  type        = string
  default     = "web_anon"
}

variable "jwt_secret" {
  description = "Secret used to verify JWTs for authenticated requests (PGRST_JWT_SECRET). Leave empty to allow only anonymous access."
  type        = string
  default     = ""
}

variable "count" {
  description = "How many instances to run. PostgREST is stateless, so you can run several behind a load balancer."
  type        = number
  default     = 1
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
  description = "Resources for the PostgREST task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
