variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "jenkins"
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
  description = "The Jenkins container image. Pin a tag in production."
  type        = string
  default     = "jenkins/jenkins:lts-jdk17"
}

variable "port" {
  description = "Host port for the Jenkins web UI."
  type        = number
  default     = 8080
}

variable "agent_port" {
  description = "Port for inbound JNLP build agents (JENKINS_SLAVE_AGENT_PORT)."
  type        = number
  default     = 50000
}

variable "data_volume" {
  description = "Named volume mounted at /var/jenkins_home (all Jenkins state)."
  type        = string
  default     = "jenkins_data"
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
    memory = 1024
  }
}
