# state.tf
terraform {
  backend "s3" {
    bucket  = "meu-bucket-marcelov"
    key     = "marcelo-site/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

  }
}
