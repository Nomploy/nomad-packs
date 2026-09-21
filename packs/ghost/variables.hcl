variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ghost"
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

# --- Ghost ----------------------------------------------------------------

variable "image" {
  description = "The Ghost container image. Pin a tag in production."
  type        = string
  default     = "ghost:5-alpine"
}

variable "port" {
  description = "Host port for Ghost (site + /ghost admin)."
  type        = number
  default     = 2368
}

variable "url" {
  description = "Public URL Ghost is served at (e.g. https://blog.example.com). Ghost bakes this into links, so set it correctly. Empty = http://localhost:<port>."
  type        = string
  default     = ""
}

variable "content_volume" {
  description = "Docker named volume for /var/lib/ghost/content (themes, images, uploads). A prestart task chowns it to uid 1000 (the node user). Back it up."
  type        = string
  default     = "ghost_content"
}

variable "ghost_resources" {
  description = "Resources for the Ghost task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

# --- MySQL (bundled; Ghost 5 requires MySQL 8) ----------------------------

variable "mysql_image" {
  description = "MySQL image. Ghost 5 requires MySQL 8 (MariaDB is not supported)."
  type        = string
  default     = "mysql:8"
}

variable "db_port" {
  description = "Host port MySQL listens on. Ghost connects on 127.0.0.1."
  type        = number
  default     = 3306
}

variable "db_password" {
  description = "Password for Ghost's MySQL user. CHANGE THIS. (DB name and user are both \"ghost\".)"
  type        = string
  default     = "ghost"
}

variable "db_root_password" {
  description = "MySQL root password. CHANGE THIS."
  type        = string
  default     = "ghost"
}

variable "db_data_volume" {
  description = "Docker named volume for /var/lib/mysql (the database — posts, members, settings). Back it up."
  type        = string
  default     = "ghost_db_data"
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

# --- Placement ------------------------------------------------------------

variable "constraints" {
  description = "Placement constraints — pin the job to one node so the local volumes stay put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}
