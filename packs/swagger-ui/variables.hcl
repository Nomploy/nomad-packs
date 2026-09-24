variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "swagger-ui"
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
  description = "The Swagger UI container image. Pin a tag in production."
  type        = string
  default     = "swaggerapi/swagger-ui:latest"
}

variable "port" {
  description = "Host port for the Swagger UI web server (PORT)."
  type        = number
  default     = 8112
}

variable "spec_url" {
  description = "URL of the OpenAPI/Swagger spec to render (URL). Point this at your API's spec."
  type        = string
  default     = "https://petstore.swagger.io/v2/swagger.json"
}

variable "count" {
  description = "How many instances to run. Swagger UI is stateless, so you can run several."
  type        = number
  default     = 1
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
  description = "Resources for the Swagger UI task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
