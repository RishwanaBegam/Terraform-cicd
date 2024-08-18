terraform {
  backend "s3" {
    bucket = "rishwana-backend-test"
    region = "us-east-1"
    key = "rish./terraform.tfstate"   # folder path for storing the statefile in s3 bucket 
    encrypt        = true
    dynamodb_table = "terraform-lock"    #dynamoDB table name
  }
}
