variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "whisper-asr"
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
  description = "The Whisper ASR Webservice image. Pin a tag in production."
  type        = string
  default     = "onerahmet/openai-whisper-asr-webservice:latest"
}

variable "port" {
  description = "Host port for the ASR HTTP API. The container listens on 9000."
  type        = number
  default     = 9000
}

variable "asr_model" {
  description = "Whisper model size (ASR_MODEL): tiny, base, small, medium, large-v3. Bigger = more accurate but slower and heavier."
  type        = string
  default     = "base"
}

variable "asr_engine" {
  description = "Inference engine (ASR_ENGINE): openai_whisper, faster_whisper, or whisperx."
  type        = string
  default     = "faster_whisper"
}

variable "cache_volume" {
  description = "Named volume for the downloaded model cache (/root/.cache). Avoids re-downloading on restart."
  type        = string
  default     = "whisper_cache"
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
  description = "Resources for the Whisper task. Speech-to-text is CPU/RAM heavy; larger models need much more."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 2048
  }
}
