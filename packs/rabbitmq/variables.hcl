variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "rabbitmq"
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
  description = "The RabbitMQ container image — use a `-management` tag so the web UI is included."
  type        = string
  default     = "rabbitmq:4-management"
}

variable "amqp_port" {
  description = "Host port for AMQP (client connections)."
  type        = number
  default     = 5672
}

variable "management_port" {
  description = "Host port for the management web UI / HTTP API."
  type        = number
  default     = 15672
}

variable "default_user" {
  description = "Admin user created on first boot. (The built-in `guest` user only works from localhost, so remote clients need this.)"
  type        = string
  default     = "admin"
}

variable "default_password" {
  description = "Password for default_user. CHANGE THIS. Only applied on first boot (empty data volume)."
  type        = string
  default     = "rabbitmq"
}

variable "data_volume" {
  description = "Docker named volume for /var/lib/rabbitmq (Mnesia DB: queues, exchanges, users, messages). A fresh volume inherits the image's dir ownership (uid 999). Back it up."
  type        = string
  default     = "rabbitmq_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
