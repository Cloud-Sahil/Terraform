provider "aws" {
  region = "eu-north-1"
}

# ---------------- Security Group ----------------
resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = "vpc-0d8f7a6a46e42fc62"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

# ---------------- Launch Templates ----------------
resource "aws_launch_template" "lt-home" {
  name          = "home"
  image_id      = "ami-05d62b9bc5a6ca605"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt update -y
    apt install -y nginx
    echo "Hello, Home" > /var/www/html/index.html
    systemctl start nginx
    systemctl enable nginx
EOF
  )
}

resource "aws_launch_template" "lt-cloth" {
  name          = "cloth"
  image_id      = "ami-05d62b9bc5a6ca605"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt update -y
    apt install -y nginx
    mkdir -p /var/www/html/cloth
    echo "Hello, cloth" > /var/www/html/cloth/index.html
    systemctl start nginx
    systemctl enable nginx
EOF
  )
}

# ---------------- Target Groups ----------------
resource "aws_lb_target_group" "home_tg" {
  name     = "home"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0d8f7a6a46e42fc62"
}

resource "aws_lb_target_group" "cloth_tg" {
  name     = "cloth"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0d8f7a6a46e42fc62"
}

# ---------------- ALB ----------------
resource "aws_lb" "alb" {
  name               = "alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]

  subnets = [
    "subnet-0173c2a6d326a5894",
    "subnet-0f52033c8d4fc65e1"
  ]
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.home_tg.arn
  }
}

resource "aws_lb_listener_rule" "cloth_rule" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cloth_tg.arn
  }

  condition {
    path_pattern {
      values = ["/cloth/*"]
    }
  }
}

# ---------------- ASG ----------------
resource "aws_autoscaling_group" "asg_home" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  vpc_zone_identifier = [
    "subnet-0173c2a6d326a5894",
    "subnet-0f52033c8d4fc65e1"
  ]

  launch_template {
    id      = aws_launch_template.lt-home.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.home_tg.arn]
}

resource "aws_autoscaling_group" "asg_cloth" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  vpc_zone_identifier = [
    "subnet-0173c2a6d326a5894",
    "subnet-0f52033c8d4fc65e1"
  ]

  launch_template {
    id      = aws_launch_template.lt-cloth.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.cloth_tg.arn]
}
