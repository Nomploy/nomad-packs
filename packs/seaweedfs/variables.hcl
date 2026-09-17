variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "seaweedfs"
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
  description = "The SeaweedFS container image. Pin a tag in production."
  type        = string
  default     = "chrislusf/seaweedfs:latest"
}

variable "s3_port" {
  description = "Host port for the S3-compatible API — the endpoint your S3 clients use."
  type        = number
  default     = 8333
}

variable "master_port" {
  description = "Host port for the master server + its web UI. SeaweedFS also binds the gRPC port master_port+10000 on the host."
  type        = number
  default     = 9333
}

variable "volume_port" {
  description = "Host port for the volume server (+10000 for its gRPC port). Default 8080 — change it if another host service already uses 8080."
  type        = number
  default     = 8080
}

variable "filer_port" {
  description = "Host port for the filer + its web UI (+10000 for its gRPC port)."
  type        = number
  default     = 8888
}

variable "access_key" {
  description = "S3 access key for the admin identity. Leave BOTH access_key and secret_key empty to run open (Allow-All mode, anonymous access). Set both to require authentication for all S3 requests."
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "S3 secret key for the admin identity. Baked into the job as a rendered config — treat it as a secret."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /data (object data + master + filer metadata). This is all of SeaweedFS's state — back it up. SeaweedFS runs as root, so a fresh volume is writable."
  type        = string
  default     = "seaweedfs_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put (this pack runs a single all-in-one alloc). On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources. Raise memory for large datasets — the volume server keeps needle indexes in memory."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
