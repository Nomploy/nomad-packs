variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "nginx"
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
  description = "The nginx container image."
  type        = string
  default     = "nginx:alpine"
}

variable "port" {
  description = "Host port nginx listens on (host networking). Default 8080 to avoid clashing with Traefik on :80. Pick a free port on the target node."
  type        = number
  default     = 8080
}

variable "count" {
  description = "Number of instances. Static content is stateless, so this can safely be > 1 (each replica needs its own node in host-network mode)."
  type        = number
  default     = 1
}

variable "index_html" {
  description = "Contents of index.html, rendered into the alloc and served at /. Replace with your own static page."
  type        = string
  default     = "<!doctype html><html><head><title>nginx on Nomad</title></head><body style=\"font-family:system-ui;max-width:40rem;margin:4rem auto;padding:0 1rem\"><h1>It works</h1><p>Served by nginx, deployed as a Nomad Pack. Edit the <code>index_html</code> variable to replace this page.</p></body></html>"
}

variable "resources" {
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
