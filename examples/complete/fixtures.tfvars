namespace = "eg"

stage = "test"

name = "ecs-codepipeline"

vpc_cidr_block = "172.16.0.0/16"

deployment_minimum_healthy_percent = 100

deployment_maximum_percent = 200

desired_count = 1

task_memory = 512

task_cpu = 256

container_name = "geodesic"

container_image = "cloudposse/geodesic"

container_memory = 256

container_memory_reservation = 128

container_cpu = 256

container_environment = [
  {
    name  = "string_var"
    value = "I am a string"
  },
  {
    name  = "true_boolean_var"
    value = true
  },
  {
    name  = "false_boolean_var"
    value = false
  },
  {
    name  = "integer_var"
    value = 42
  }
]

container_port_mappings = [
  {
    containerPort = 80
    hostPort      = 80
    protocol      = "tcp"
  },
  {
    containerPort = 443
    hostPort      = 443
    protocol      = "udp"
  }
]

github_oauth_token = "test"

repo_owner = "delonx"

repo_name = "terraform-aws-ecs-codepipeline"

branch = "master"

build_image = "aws/codebuild/docker:17.09.0"

build_compute_type = "BUILD_GENERAL1_SMALL"

build_timeout = 60

poll_source_changes = false

privileged_mode = true

image_repo_name = "terraform-aws-ecs-codepipeline"

image_tag = "latest"

webhook_enabled = false

environment_variables = [
  {
    name  = "APP_URL"
    value = "https://app.example.com"
    type  = "PLAINTEXT"
  },
  {
    name  = "COMPANY_NAME"
    value = "Cloud Posse"
    type  = "PLAINTEXT"
  },
  {
    name  = "TIME_ZONE"
    value = "America/Los_Angeles"
    type  = "PLAINTEXT"

  }
]
