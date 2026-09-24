variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "zigbee2mqtt"
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
  description = "The Zigbee2MQTT container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/koenkk/zigbee2mqtt:latest"
}

variable "port" {
  description = "Host port for the web frontend (ZIGBEE2MQTT_CONFIG_FRONTEND_PORT)."
  type        = number
  default     = 8124
}

variable "serial_device" {
  description = "Host path to your Zigbee USB coordinator, passed into the container. Prefer a stable /dev/serial/by-id/... path."
  type        = string
  default     = "/dev/ttyACM0"
}

variable "mqtt_server" {
  description = "MQTT broker URL (ZIGBEE2MQTT_CONFIG_MQTT_SERVER). Point at the mosquitto pack on this node."
  type        = string
  default     = "mqtt://127.0.0.1:1883"
}

variable "data_volume" {
  description = "Named volume for Zigbee2MQTT data (/app/data): config, database, and the network state."
  type        = string
  default     = "zigbee2mqtt_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node with the Zigbee adapter and the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Zigbee2MQTT task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
