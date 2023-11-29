provider "aws" {
    region ="us-east-1"
  
}

resource "aws_instance" "ec2_for_springboot" {
    ami = "ami-06aa3f7caf3a30282"
    instance_type = "t2.micro"
    tags ={
        Name = "ec2_for_springboot"}
}


