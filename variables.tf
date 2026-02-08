variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "name_prefix" {
  type    = string
  default = "ci-infra"
}

variable "bucket_name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI (region specific)"
  type        = string
}

variable "key_name" {
  description = "Optional EC2 key pair name (leave empty if not using SSH)"
  type        = string
  default     = ""
}
