variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "mattermost"
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
  description = "The Mattermost Team Edition container image. Pin a tag in production."
  type        = string
  default     = "mattermost/mattermost-team-edition:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the Mattermost web UI / API."
  type        = number
  default     = 8065
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Mattermost PostgreSQL user."
  type        = string
  default     = "mattermost"
}

variable "site_url" {
  description = "Public URL Mattermost is served at (MM_SERVICESETTINGS_SITEURL). Empty = http://localhost:<port>. Set this to the real host/domain."
  type        = string
  default     = ""
}

variable "uid" {
  description = "UID Mattermost runs as. The mounted dirs are chown'd to this at startup."
  type        = number
  default     = 2000
}

variable "config_volume" {
  description = "Named volume for Mattermost config (/mattermost/config)."
  type        = string
  default     = "mattermost_config"
}

variable "data_volume" {
  description = "Named volume for uploaded files (/mattermost/data)."
  type        = string
  default     = "mattermost_data"
}

variable "plugins_volume" {
  description = "Named volume for plugins (/mattermost/plugins)."
  type        = string
  default     = "mattermost_plugins"
}

variable "client_plugins_volume" {
  description = "Named volume for client plugin bundles (/mattermost/client/plugins)."
  type        = string
  default     = "mattermost_client_plugins"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all messages."
  type        = string
  default     = "mattermost_db_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Mattermost app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "postgres_resources" {
  description = "Resources for the PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
