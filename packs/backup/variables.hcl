variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "backup"
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
  description = "The restic container image."
  type        = string
  default     = "restic/restic:latest"
}

variable "volumes" {
  description = "Docker named volumes to back up (e.g. [\"postgres_data\", \"gitea_data\"]). Each is mounted read-only and snapshotted. REQUIRED — an empty list backs up nothing. Named volumes are node-local, so pin this job (constraints) to the node that holds them."
  type        = list(string)
  default     = []
}

variable "cron" {
  description = "Backup schedule (Nomad periodic cron). Default: daily at 03:00."
  type        = string
  default     = "0 3 * * *"
}

variable "time_zone" {
  description = "Time zone for the cron schedule (IANA name, e.g. Europe/Bratislava)."
  type        = string
  default     = "UTC"
}

variable "repository" {
  description = "restic repository URL. For the seaweedfs pack: s3:http://<node-ip>:8333/<bucket>. The bucket/target must already exist. restic init runs automatically on first backup."
  type        = string
  default     = "s3:http://127.0.0.1:8333/backups"
}

variable "restic_password" {
  description = "Password that encrypts the restic repository. CHANGE THIS and keep it safe — without it the backups are unrecoverable."
  type        = string
  default     = "changeme"
}

variable "access_key" {
  description = "S3 access key for the repository (AWS_ACCESS_KEY_ID). Empty for an open S3 target."
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "S3 secret key for the repository (AWS_SECRET_ACCESS_KEY)."
  type        = string
  default     = ""
}

variable "keep_daily" {
  description = "Retention: number of daily snapshots to keep."
  type        = number
  default     = 7
}

variable "keep_weekly" {
  description = "Retention: number of weekly snapshots to keep."
  type        = number
  default     = 4
}

variable "keep_monthly" {
  description = "Retention: number of monthly snapshots to keep."
  type        = number
  default     = 6
}

variable "constraints" {
  description = "Placement constraints — REQUIRED in practice: pin to the node holding the named volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
