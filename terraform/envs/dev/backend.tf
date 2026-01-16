terraform {
  backend "s3" {
    bucket         = ""
    key            = ""
    region         = var.region
    encrypt        = true
    dynamodb_table = "" # Name of your pre-created DynamoDB table
  }
}
