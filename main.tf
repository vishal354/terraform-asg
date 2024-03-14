terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Launch template for autoscaling group
resource "aws_launch_template" "launch_template" {
  name                   = "tf-${var.service_name}-template"
  image_id               = var.image_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.instance_security_group_ids
}

# Target Group for Load Balancer
resource "aws_lb_target_group" "app_target_group" {
  name     = "tf-${var.service_name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }
}

# Load balancer for the service
resource "aws_lb" "load_balancer" {
  name               = "tf-${var.service_name}-alb"
  internal           = false
  security_groups    = var.load_balancer_security_group_ids
  subnets            = var.elb_subnets
  load_balancer_type = "application"
}

# Create listener for the load balancer
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}


# Autoscaling group for the service
resource "aws_autoscaling_group" "autoscaling_group" {
  name               = "tf-${var.service_name}-asg"
  availability_zones = var.availability_zones
  desired_capacity   = var.asg_desired_capacity
  max_size           = var.asg_max_size
  min_size           = var.asg_min_size
  target_group_arns  = [aws_lb_target_group.app_target_group.arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "tf-${var.env_name}-${var.service_name}"
    propagate_at_launch = true
  }
}
