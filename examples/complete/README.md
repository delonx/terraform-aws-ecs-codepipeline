# Simple Elastic Container Service

This repository sets up a simple Elastic Container Service environment with AWS Code Pipeline triggered from Github Action for demo purposes.

## Getting started

### Prerequisites

Copy the set of files in this repository into a new project-specific folder. You will also need an AWS account with a set of API credentials that has sufficient permissions.

### Installation

Install `terraform` via `homebrew`

```zsh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

Install the `aws-cli` by following the official instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

### Configure credentials

Configure the `aws-cli` from your terminal by following the prompts to input your AWS Access Key ID and Secret Access Key.

```zsh
aws configure
```

Alternatively, supply your credentials by modifying the `~/.aws/credentials` file directly:

```txt
[your-aws-profile-name]
aws_access_key_id=<your-aws-access-key-id>
aws_secret_access_key=<your-secret-access-key>
```

### Initialise your project directory

```zsh
terraform init
```

Terraform downloads the aws provider and installs it in a hidden subdirectory of your current working directory, named `.terraform`. The terraform init command prints out which version of the provider was installed. Terraform also considers the existing lock file named `.terraform.lock.hcl` which specifies the exact provider versions used, so that you can control when you want to update the providers used for your project.

### Configuration

Edit the existing `fixtures.ap-southeast-1.tfvars` in the project directory to suit your needs.

The stack creates a ECS Fargate Cluster fronted by AWS Application Load Balancer by default.

### Initialise Terraform

Initialise the new Terraform working directory with the following command:

```zsh
terraform init
```

This will install the necessary modules for your working directory. You should see output similar to the following:

```zsh
Initializing modules...
(truncated)

Initializing the backend...

Initializing provider plugins...

(truncated)

Terraform has been successfully initialized!
```

### Creating your infrastructure

First, create a new Terraform *workspace* called "staging":

```zsh
terraform workspace new staging
```

This will help to identify and isolate staging resources from any production resources you may create in future, should you choose to do so.

Next, validate the terraform configuration with this command:

```zsh
terraform validate
```

You should see output such as the following:

```zsh
Success! The configuration is valid.
```

If there are errors, address any issues that may have been raised.

Finally, execute the following command to create your cloud infrastructure

```zsh
terraform apply -var-file="fixtures.tfvars"
```

You should see output similar to the following:

```zsh
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

(...)

Plan: 50 to add, 0 to change, 0 to destroy.

Do you want to perform these actions in workspace "staging"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

Take your time to examine the planned changes, and type `yes` to proceed.

You should see output similar to the following:

```txt
Apply complete! Resources: 50 added, 0 changed, 0 destroyed.

Outputs:

codebuild_badge_url = ""
codebuild_cache_bucket_arn = "arn:aws:s3:::eg-test-ecs-codepipeline-build-yyyyyyyyyyyy"
codebuild_cache_bucket_name = "eg-test-ecs-codepipeline-build-hzicwkynrdwd"
codebuild_project_id = "arn:aws:codebuild:ap-southeast-1:xxxxxxxxxxxxx:project/eg-test-ecs-codepipeline-build"
codebuild_project_name = "eg-test-ecs-codepipeline-build"
codebuild_role_arn = "arn:aws:iam::xxxxxxxxxxxxx:role/eg-test-ecs-codepipeline-build"
codebuild_role_id = "eg-test-ecs-codepipeline-build"
codepipeline_arn = "arn:aws:codepipeline:ap-southeast-1:xxxxxxxxxxxxx:eg-test-ecs-codepipeline-codepipeline"
codepipeline_id = "eg-test-ecs-codepipeline-codepipeline"
container_definition_json = "[{\"cpu\":256,\"environment\":[{\"name\":\"false_boolean_var\",\"value\":\"false\"},{\"name\":\"integer_var\",\"value\":\"42\"},{\"name\":\"string_var\",\"value\":\"I am a string\"},{\"name\":\"true_boolean_var\",\"value\":\"true\"}],\"essential\":true,\"image\":\"cloudposse/geodesic\",\"memory\":256,\"memoryReservation\":128,\"mountPoints\":[],\"name\":\"geodesic\",\"portMappings\":[{\"containerPort\":80,\"hostPort\":80,\"protocol\":\"tcp\"},{\"containerPort\":443,\"hostPort\":443,\"protocol\":\"udp\"}],\"readonlyRootFilesystem\":false,\"volumesFrom\":[]}]"
container_definition_json_map = "{\"cpu\":256,\"environment\":[{\"name\":\"false_boolean_var\",\"value\":\"false\"},{\"name\":\"integer_var\",\"value\":\"42\"},{\"name\":\"string_var\",\"value\":\"I am a string\"},{\"name\":\"true_boolean_var\",\"value\":\"true\"}],\"essential\":true,\"image\":\"cloudposse/geodesic\",\"memory\":256,\"memoryReservation\":128,\"mountPoints\":[],\"name\":\"geodesic\",\"portMappings\":[{\"containerPort\":80,\"hostPort\":80,\"protocol\":\"tcp\"},{\"containerPort\":443,\"hostPort\":443,\"protocol\":\"udp\"}],\"readonlyRootFilesystem\":false,\"volumesFrom\":[]}"
ecs_cluster_arn = "arn:aws:ecs:ap-southeast-1:xxxxxxxxxxxxx:cluster/eg-test-ecs-codepipeline"
ecs_cluster_id = "arn:aws:ecs:ap-southeast-1:xxxxxxxxxxxxx:cluster/eg-test-ecs-codepipeline"
ecs_exec_role_policy_id = "eg-test-ecs-codepipeline-exec:eg-test-ecs-codepipeline-exec"
ecs_exec_role_policy_name = "eg-test-ecs-codepipeline-exec"
private_subnet_cidrs = [
  "172.16.0.0/19",
  "172.16.32.0/19",
]
public_subnet_cidrs = [
  "172.16.96.0/19",
  "172.16.128.0/19",
]
service_name = "eg-test-ecs-codepipeline"
service_role_arn = ""
service_security_group_id = "sg-0123456789012345"
task_definition_family = "eg-test-ecs-codepipeline"
task_definition_revision = "3"
task_exec_role_arn = "arn:aws:iam::xxxxxxxxxxxxx:role/eg-test-ecs-codepipeline-exec"
task_exec_role_name = "eg-test-ecs-codepipeline-exec"
task_role_arn = "arn:aws:iam::xxxxxxxxxxxxx:role/eg-test-ecs-codepipeline-task"
task_role_id = "ABCDEFGHIJKLMNOPQRST"
task_role_name = "eg-test-ecs-codepipeline-task"
vpc_cidr = "172.16.0.0/16"
webhook_id = ""
webhook_url = <sensitive>
```

### Tearing down the infrastructure

Run the following command to remove all created infrastructure:

```zsh
terraform destroy -var-file="fixtures.tfvars"
```
