variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "open-webui"
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
  description = "The Open WebUI container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/open-webui/open-webui:main"
}

variable "port" {
  description = "Host port for the Open WebUI web app. Default 3008 to avoid other packs on 3000-3007."
  type        = number
  default     = 3008
}

variable "ollama_base_url" {
  description = "URL of the Ollama server to use. Defaults to the ollama pack on the same node (host networking)."
  type        = string
  default     = "http://127.0.0.1:11434"
}

variable "secret_key" {
  description = "Secret key for signing sessions (WEBUI_SECRET_KEY). Set a stable random value in production. Empty = Open WebUI generates one and persists it in the data volume."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /app/backend/data (SQLite DB, chats, users, settings). Open WebUI runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "open_webui_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put (ideally the node running ollama). On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
    cpu    = 500
    memory = 512
  }
}
