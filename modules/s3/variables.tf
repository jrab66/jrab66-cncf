variable "bucket_name" {
  description = "The name to be assigned to bucket and resources"
}

variable "bucket_public_acl" {
  description = "Whether or not bucket should have a publicly accessible ACL"
  default     = "private"
  type        = string
  validation {
    condition     = can(regex("private|public-read|public-read-write|authenticated-read|aws-exec-read|log-delivery-write", var.bucket_public_acl))
    error_message = "Must be one of \"private public-read public-read-write authenticated-read aws-exec-read log-delivery-write\"."
  }
}

variable "block_public_acls" {
  description = "Enable public acl block"
  default     = true
  type        = bool
}

variable "block_public_policy" {
  description = "Enable block_public_policy"
  default     = true
  type        = bool
}

variable "restrict_public_buckets" {
  description = "Enable restrict_public_buckets"
  default     = true
  type        = bool
}

variable "ignore_public_acls" {
  description = "Enable ignore_public_acls"
  default     = true
  type        = bool
}

variable "enable_versioning" {
  description = "Whether or not to enable object versioning"
  default     = true
  type        = bool
}

variable "access_logging" {
  description = "Whether or not to enable access logging on the bucket"
  default     = true
}

variable "access_logging_bucket" {
  description = "Destination for access logging"
  default     = ""
}
