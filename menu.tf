provider "aws" {
  region = "us-east-1" # Specify your desired AWS region
}

# Create a Security Group
resource "aws_security_group" "example_sg" {
  name        = "example-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-sg"
  }
}

# Create an EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (replace as needed)
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.example_sg.id] # Attach security group

  tags = {
    Name = "example-ec2-instance"
  }

  # Use a key pair for SSH access (optional)
  key_name = aws_key_pair.example.key_name
}

# Create a Key Pair (for SSH access)
resource "aws_key_pair" "example" {
  key_name   = "example-key-pair"
  public_key = "ssh-rsa AAAA..." # Replace with your public SSH key
}
