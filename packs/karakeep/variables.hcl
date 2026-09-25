variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "karakeep"
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
  description = "The Karakeep web image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/karakeep-app/karakeep:release"
}

variable "meilisearch_image" {
  description = "The Meilisearch image used for full-text search."
  type        = string
  default     = "getmeili/meilisearch:v1.13.3"
}

variable "chrome_image" {
  description = "The headless Chrome image used to fetch and archive pages."
  type        = string
  default     = "gcr.io/zenika/alpine-chrome:123"
}

variable "port" {
  description = "Host port for the Karakeep web UI."
  type        = number
  default     = 3000
}

variable "meili_port" {
  description = "Host port for the bundled Meilisearch (loopback only)."
  type        = number
  default     = 7700
}

variable "chrome_port" {
  description = "Host port for the headless Chrome remote-debugging endpoint (loopback only)."
  type        = number
  default     = 9222
}

variable "nextauth_secret" {
  description = "Session signing secret (NEXTAUTH_SECRET). CHANGE THIS. Generate with: openssl rand -base64 36."
  type        = string
  default     = "change-me-openssl-rand-base64-36"
}

variable "meili_master_key" {
  description = "Meilisearch master key (MEILI_MASTER_KEY), shared by the app and the search engine. CHANGE THIS. Generate with: openssl rand -base64 36."
  type        = string
  default     = "change-me-openssl-rand-base64-36"
}

variable "base_url" {
  description = "Public URL Karakeep is reachable at (NEXTAUTH_URL). Empty = http://localhost:<port>. Set this to your real host/domain."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume mounted at /data — the app's SQLite database and assets."
  type        = string
  default     = "karakeep_data"
}

variable "meili_data_volume" {
  description = "Named volume mounted at /meili_data — the search index."
  type        = string
  default     = "karakeep_meili"
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
  description = "Resources for the Karakeep web task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "meilisearch_resources" {
  description = "Resources for the Meilisearch task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 512
  }
}

variable "chrome_resources" {
  description = "Resources for the headless Chrome task. Rendering pages is memory-hungry."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 768
  }
}
