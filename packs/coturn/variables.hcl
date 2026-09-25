variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "coturn"
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
  description = "The coturn container image. Pin a tag in production."
  type        = string
  default     = "coturn/coturn:latest"
}

variable "port" {
  description = "Main TURN/STUN listening port (TCP + UDP)."
  type        = number
  default     = 3478
}

variable "realm" {
  description = "TURN realm — usually your domain (--realm)."
  type        = string
  default     = "turn.example.com"
}

variable "turn_user" {
  description = "Long-term-credential username (--user <user>:<password>)."
  type        = string
  default     = "turn"
}

variable "turn_password" {
  description = "Long-term-credential password. CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "external_ip" {
  description = "Public IP to advertise for relayed candidates (--external-ip). Empty = auto-detect; set it if the node is behind 1:1 NAT."
  type        = string
  default     = ""
}

variable "min_port" {
  description = "Lowest UDP relay port (--min-port). Open this range on the firewall."
  type        = number
  default     = 49160
}

variable "max_port" {
  description = "Highest UDP relay port (--max-port). Keep the range small unless you expect many concurrent calls."
  type        = number
  default     = 49200
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
  description = "Resources for the coturn task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 128
  }
}
