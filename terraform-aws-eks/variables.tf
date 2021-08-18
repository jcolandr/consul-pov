variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "owner" {
  description = "value of owner tag for aws resources"
}

variable "ttl" {
  description = "value of ttl tag for aws resources"
}