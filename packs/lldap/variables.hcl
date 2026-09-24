variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "lldap"
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
  description = "The LLDAP container image. Pin a tag in production."
  type        = string
  default     = "lldap/lldap:stable"
}

variable "web_port" {
  description = "Host port for the web UI (LLDAP_HTTP_PORT)."
  type        = number
  default     = 17170
}

variable "ldap_port" {
  description = "Host port for the LDAP protocol (LLDAP_LDAP_PORT)."
  type        = number
  default     = 3890
}

variable "base_dn" {
  description = "LDAP base DN (LLDAP_LDAP_BASE_DN). Set this to your domain, e.g. dc=example,dc=com."
  type        = string
  default     = "dc=example,dc=com"
}

variable "admin_password" {
  description = "Password for the default 'admin' user (LLDAP_LDAP_USER_PASS). CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "jwt_secret" {
  description = "Secret used to sign session tokens (LLDAP_JWT_SECRET). CHANGE THIS — generate with: openssl rand -hex 32."
  type        = string
  default     = "change-me-to-a-random-secret"
}

variable "data_volume" {
  description = "Named volume for LLDAP data (/data): the SQLite database and private key."
  type        = string
  default     = "lldap_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the LLDAP task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
