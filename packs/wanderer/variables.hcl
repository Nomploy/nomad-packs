variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "wanderer"
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
  description = "The wanderer web image. Pin a tag in production (keep it in sync with db_image)."
  type        = string
  default     = "flomp/wanderer-web:latest"
}

variable "db_image" {
  description = "The wanderer database (PocketBase) image. Keep its tag in sync with the web image."
  type        = string
  default     = "flomp/wanderer-db:latest"
}

variable "meilisearch_image" {
  description = "The Meilisearch image used for trail search."
  type        = string
  default     = "getmeili/meilisearch:v1.11.3"
}

variable "port" {
  description = "Host port for the wanderer web UI."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Host port for the PocketBase database/API."
  type        = number
  default     = 8090
}

variable "meili_port" {
  description = "Host port for the bundled Meilisearch (loopback only)."
  type        = number
  default     = 7700
}

variable "base_url" {
  description = "Public URL the web UI is reached at (ORIGIN). Empty = http://localhost:<port>. Set to your real host/domain."
  type        = string
  default     = ""
}

variable "pocketbase_url" {
  description = "Public URL the BROWSER uses to reach the database (PUBLIC_POCKETBASE_URL). Must be reachable from clients, e.g. http://your-host:8090. Empty = http://localhost:<db_port>."
  type        = string
  default     = ""
}

variable "meili_master_key" {
  description = "Meilisearch master key (MEILI_MASTER_KEY), shared by the db and search engine. CHANGE THIS. Generate with: openssl rand -base64 36."
  type        = string
  default     = "change-me-openssl-rand-base64-36"
}

variable "pocketbase_encryption_key" {
  description = "PocketBase settings encryption key (POCKETBASE_ENCRYPTION_KEY). MUST be exactly 32 characters. CHANGE THIS and keep it stable."
  type        = string
  default     = "0123456789abcdef0123456789abcdef"
}

variable "data_volume" {
  description = "Named volume mounted at /pb_data — the PocketBase database and uploaded GPX/photos."
  type        = string
  default     = "wanderer_data"
}

variable "meili_data_volume" {
  description = "Named volume for the Meilisearch index."
  type        = string
  default     = "wanderer_meili"
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
  description = "Resources for the wanderer web task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "db_resources" {
  description = "Resources for the PocketBase database task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
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
