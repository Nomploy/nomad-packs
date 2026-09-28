variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "huginn"
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
  description = "The Huginn all-in-one container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/huginn/huginn:latest"
}

variable "port" {
  description = "Host port for the Huginn web UI."
  type        = number
  default     = 3000
}

variable "admin_user" {
  description = "Admin username seeded on first start."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Admin password seeded on first start. CHANGE THIS."
  type        = string
  default     = "huginn_change_me"
}

variable "app_secret_token" {
  description = "Secret token used to sign cookies (128-char hex, openssl rand -hex 64). CHANGE THIS."
  type        = string
  default     = "change_me_to_a_128_char_random_hex_secret_00000000000000000000000000000000000000000000000000000000000000000000000000000000"
}

variable "domain" {
  description = "Domain/host:port used in generated links (e.g. huginn.example.com)."
  type        = string
  default     = "localhost:3000"
}

variable "data_volume" {
  description = "Named volume for the bundled MySQL data (/var/lib/mysql)."
  type        = string
  default     = "huginn_data"
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1536
  }
}
