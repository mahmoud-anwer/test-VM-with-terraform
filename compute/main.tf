

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"

  # for_each = toset(["1", "2"])

  # name = "web server-${each.key}"
  name          = "test vm"
  ami           = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type = var.instance_type
  key_name      = "test-vm"

  monitoring             = false
  vpc_security_group_ids = [data.terraform_remote_state.networking.outputs.ec2_sg]
  subnet_id              = data.terraform_remote_state.networking.outputs.vpc_public_subnets[0]
  ebs_optimized          = true
  root_block_device = [
    {
      volume_size = 25
    }
  ]

  # user_data = templatefile("./user_data.tpl")
  # user_data   = "./user_data.tpl"

  user_data                   = file("user_data.sh")
  user_data_replace_on_change = true

  tags = local.common_tags
}