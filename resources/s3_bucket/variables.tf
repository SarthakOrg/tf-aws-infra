variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "transition_days" {
  description = "Number of days after which the object transitions to STANDARD_IA storage class"
  type        = number
  default     = 30
}
