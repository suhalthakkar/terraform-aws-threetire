provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "ststatefilebucket"
    key    = "compute/terraform.tfstate"
    region = "eu-west-1"
  }
}

resource "aws_security_group" "instance_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}

resource "aws_lb_target_group" "tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-template"
  image_id      = "ami-0e82046e2f06c0a68 "
  instance_type = "t2.micro"
  security_group_names = [aws_security_group.app_sg.name]

  user_data = base64encode(<<EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo "Hello from $(hostname -f)" > /var/www/html/index.html
  EOF
  )
}

resource "aws_autoscaling_group" "asg" {
  name                      = "terraform-asg"
  vpc_zone_identifier       = var.public_subnet_ids
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 3
  launch_configuration      = aws_launch_configuration.main.name
  target_group_arns = [aws_lb_target_group.tg.arn]

  depends_on = [aws_security_group.instance_sg]
}