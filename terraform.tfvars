region        = "us-east-1"
vpc_id        = "vpc-03b4bf068f247be2a"
key_name      = "wordpress-key"
service_name  = "uptime-kuma"
instance_type = "t2.micro"
image_id      = "ami-052bfded4fe4eb1be"
env_name      = "test"

asg_desired_capacity = 1
asg_max_size         = 1
asg_min_size         = 1

instance_security_group_ids      = ["sg-0b6143e494b5b799e"]
load_balancer_security_group_ids = ["sg-0b6143e494b5b799e"]
availability_zones               = ["us-east-1a", "us-east-1b"]
elb_subnets                      = ["subnet-07945bdbb3ba1d460", "subnet-0d056e41e4bdf79ca"]

root_block_size = 8