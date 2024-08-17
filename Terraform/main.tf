provider "aws" {
    region = "us-east-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
    ami           = "ami-04a81a99f5ec58529"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    #subnet_id = "subnet-0600ab3ed0c5fd24c"   # can select default subnet or specify desired subnet id
    key_name = "aws-login"
}
