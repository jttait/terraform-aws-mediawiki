resource "aws_security_group" "mediawiki" {
  name        = "Inbound HTTP and HTTPS"
  description = "Inbound HTTP and HTTPS"
  vpc_id      = ""
  ingress {
    description = "Allow inbound HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow inbound HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow inbound SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description      = "Allow all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "mediawiki" {
  ami                         = "ami-0d09654d0a20d3ae2"
  instance_type               = "t2.micro"
  user_data                   = file("start.sh")
  user_data_replace_on_change = true
  key_name                    = "KeyPair"
  security_groups             = [aws_security_group.mediawiki.name]
  depends_on                  = [aws_security_group.mediawiki]
}