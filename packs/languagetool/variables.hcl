variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "languagetool"
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
  description = "The LanguageTool container image. Pin a tag in production."
  type        = string
  default     = "erikvl87/languagetool:latest"
}

variable "port" {
  description = "Host port for the LanguageTool HTTP API. Fixed at 8010 inside the image."
  type        = number
  default     = 8010
}

variable "java_xms" {
  description = "JVM initial heap size (Java_Xms)."
  type        = string
  default     = "256m"
}

variable "java_xmx" {
  description = "JVM maximum heap size (Java_Xmx). Keep this below the task memory limit."
  type        = string
  default     = "512m"
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
    cpu    = 500
    memory = 768
  }
}
