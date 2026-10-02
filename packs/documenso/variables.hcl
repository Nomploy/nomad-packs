variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "documenso"
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
  description = "The Documenso container image. Pin a tag in production."
  type        = string
  default     = "documenso/documenso:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16"
}

variable "openssl_image" {
  description = "Image used by the init task to generate the self-signed signing certificate."
  type        = string
  default     = "alpine/openssl:latest"
}

variable "port" {
  description = "Host port for the Documenso web UI."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL (loopback only)."
  type        = number
  default     = 5432
}

variable "webapp_url" {
  description = "Public URL of this Documenso instance (used for links and callbacks)."
  type        = string
  default     = "http://localhost:3000"
}

variable "nextauth_secret" {
  description = "Secret used to sign auth sessions (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_nextauth_secret_to_a_long_random_value"
}

variable "encryption_key" {
  description = "Primary encryption key for stored secrets (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_encryption_key_to_a_long_random_value"
}

variable "encryption_secondary_key" {
  description = "Secondary encryption key (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_secondary_key_to_a_long_random_value"
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "documenso_change_me"
}

variable "smtp_transport" {
  description = "Email transport: smtp-auth, smtp-api, resend, or mailchannels. The app boots without a working mailer, but signing emails will fail until this is configured."
  type        = string
  default     = "smtp-auth"
}

variable "smtp_host" {
  description = "SMTP server host (for smtp-auth). Leave blank to configure later."
  type        = string
  default     = ""
}

variable "smtp_port" {
  description = "SMTP server port (for smtp-auth)."
  type        = string
  default     = "587"
}

variable "smtp_username" {
  description = "SMTP username (for smtp-auth)."
  type        = string
  default     = ""
}

variable "smtp_password" {
  description = "SMTP password (for smtp-auth)."
  type        = string
  default     = ""
}

variable "smtp_from_name" {
  description = "Display name for outgoing email."
  type        = string
  default     = "Documenso"
}

variable "smtp_from_address" {
  description = "From address for outgoing email."
  type        = string
  default     = "noreply@example.com"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "documenso_db_data"
}

variable "cert_volume" {
  description = "Named volume holding the generated signing certificate."
  type        = string
  default     = "documenso_cert"
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
  description = "Resources for the Documenso app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
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
