resource "aws_instance" "mySonarInstance" {
      ami           = "ami-0e3ea3dc6b356c29a"
      key_name = var.myJenkinsEC2Key
      instance_type = "t2.micro"
      vpc_security_group_ids = [aws_security_group.sonar-sg-2023.id]
      tags= {
        Name = "sonar_instance"
      }
    }

 resource "aws_security_group" "sonar-sg-2023" {
      name        = "security_sonar_group_2023"
      description = "security group for Sonar"
      vpc_id      = "vpc-09c26d74e8ea18d08"

      ingress {
        from_port   = 9000
        to_port     = 9000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

     ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

     # outbound from Sonar server
      egress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      tags= {
        Name = "security_sonar"
      }
    }

# Create Elastic IP address for Sonar instance
resource "aws_eip" "mySonarInstance" {
  domain    = "vpc"
  instance = aws_instance.mySonarInstance.id
tags= {
    Name = "sonar_elastic_ip"
  }
}
