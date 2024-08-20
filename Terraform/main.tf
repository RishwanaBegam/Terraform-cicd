provider "aws" {
   region = "us-east-1"  # Set your desired AWS region
}

resource "aws_key_pair" "provision" {
  key_name   = "provision-key"
  #public_key = file ("C:/Users/User/.ssh/id_rsa.pub")
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC15d72ZSNcD+KL4MUyQKjxTQ7cDfB4POIntHl4adZoeyo2IEXnZC4vtLwL5eZR7EHg/6XPQPXA0K3LneUmGJB6SbT9VcdsGYJCezb9oWP89WReaNMZ9nOMFcS9dGsTir93yb9oq4IBfpVM29eliYXqQCi7/PzLvfZIzqun5DKFExmFK3VooQr6KO6k9tgMzmX7e5dufa0uAAXvw8YmrJMw5Ht0r4stNKeeoUhqQ3ci0ZDPnPTTX1qR1//8KSdbMcCQPw9XIAgBMzLhOn4pPnrzLv/ZNpeOA1Z67jvu//RFiZCnhcBjobZT9xfjotTHiTTXNQ+snylVNT6ZHBrLEvn+VgM2Xak0JrL3QHUMiIC8W1gHsLEgDkHCkwPjkSUdddJwhSiUawd/1I/woL7qLNoWKQjkjCMLt2jzcCLY13yI152ZeYDJwjO4uVbmbCcLnphBDrHEsamL/KdYsstoPPuzrYzcjzK3iyEvxaYsT1torlrwP8IjIRG4LdgqPpIZcvs= User@LAPTOP-70BV9HUI"
  
}

resource "aws_s3_bucket" "rishwana-remote-backend-test" {
  bucket = "rishwana-backend-test"        # specify bucket name
}


resource "aws_security_group" "httpsg"{
  name        = "allow-ssh-http"
  description = "Allow SSH and HTTP traffic"

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
    ami           = "ami-04a81a99f5ec58529"  # Specify an appropriate AMI ID
    instance_type = "t2.large"
    #subnet_id = "subnet-0600ab3ed0c5fd24c"   # can select default subnet or specify desired subnet id
    key_name      = aws_key_pair.provision.key_name
    security_groups = [
    aws_security_group.httpsg.name
  ]


 provisioner "file" {
    source      = "provisioner.sh"
    destination = "/tmp/provisioner.sh"
     connection {
      type        = "ssh"
      user        = "ubuntu"
      #private_key = file("c/Users/User/.ssh/id_rsa")  # Path to your SSH private key
      private_key = file("id_rsa")
      host        = self.public_ip
    }
  }

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provisioner.sh",
      "sudo /tmp/provisioner.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      #private_key = file("c/Users/User/.ssh/id_rsa")  # Path to your SSH private key
      private_key = file("id_rsa")
      host        = self.public_ip
    }
  }

   tags = {
    Name = "JenkinsServer"
  }
}

#output "jenkins_url" {
 #value = "http://${aws_instance.jenkins_server.public_ip}:8080"
#}

