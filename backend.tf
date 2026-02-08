terraform {
  backend "s3" {
    bucket  = "vimala-bucket"
    key     = "infra/dev/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}
