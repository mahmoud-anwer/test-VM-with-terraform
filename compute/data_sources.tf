
data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "terraform-state-2222"
    key    = "testing/networking.tfstate"
    region = "us-east-1"
  }
}

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/canonical/ubuntu/server/focal/stable/current/amd64/hvm/ebs-gp2/ami-id"
}