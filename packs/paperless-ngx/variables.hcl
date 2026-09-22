variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "paperless-ngx"
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
  description = "The Paperless-ngx container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/paperless-ngx/paperless-ngx:latest"
}

variable "redis_image" {
  description = "The Redis broker image."
  type        = string
  default     = "redis:7-alpine"
}

variable "port" {
  description = "Host port for the Paperless web UI (PAPERLESS_PORT)."
  type        = number
  default     = 8000
}

variable "redis_port" {
  description = "Host port for the co-located Redis broker."
  type        = number
  default     = 6379
}

variable "admin_user" {
  description = "Superuser created on first start (PAPERLESS_ADMIN_USER)."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Superuser password (PAPERLESS_ADMIN_PASSWORD). CHANGE THIS."
  type        = string
  default     = "changeme-please"
}

variable "secret_key" {
  description = "Django secret key (PAPERLESS_SECRET_KEY). Generate a long random value for production."
  type        = string
  default     = "change-me-to-a-long-random-secret-key"
}

variable "timezone" {
  description = "Time zone (PAPERLESS_TIME_ZONE)."
  type        = string
  default     = "Etc/UTC"
}

variable "ocr_language" {
  description = "Tesseract OCR language (PAPERLESS_OCR_LANGUAGE), e.g. \"eng\", \"deu\", \"eng+deu\"."
  type        = string
  default     = "eng"
}

variable "url" {
  description = "Public URL Paperless is served at (PAPERLESS_URL). Empty = not set. Required if exposed on a domain."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for the SQLite database and index (/usr/src/paperless/data)."
  type        = string
  default     = "paperless_data"
}

variable "media_volume" {
  description = "Named volume for archived documents (/usr/src/paperless/media). Critical — back it up."
  type        = string
  default     = "paperless_media"
}

variable "consume_volume" {
  description = "Named volume watched for new documents to import (/usr/src/paperless/consume)."
  type        = string
  default     = "paperless_consume"
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
  description = "Resources for the Paperless app task (OCR is CPU-heavy)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 1024
  }
}

variable "redis_resources" {
  description = "Resources for the Redis broker task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
