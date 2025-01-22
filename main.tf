provider "aws"  {

region ="us-east-1"

}

resource "aws_instnace" "one"  {
instance_type="t2.micro"
count =2 
ami=""
tags={
Name="test-ser" 

}

}
