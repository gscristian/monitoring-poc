data "terraform_remote_state" "aws_network" {
  backend = "s3"
  config = {
    region         = "eu-west-1"
    key            = "aws-network"
    bucket         = "tf-state-cgs"
    dynamodb_table = "tf-state-cgs-locks"
  }
}

module "ec2" {
  source              = "../../modules/aws/ec2/instance"
  name                = "prometheus-poc"
  vpc                 = "${data.terraform_remote_state.aws_network.outputs.vpc_id}"
  subnet              = "${data.terraform_remote_state.aws_network.outputs.subnet_az1_id}"
  system_user         = "cristian"
  github_user         = "gscristian"
  instance_type       = "t3.micro"
  #spot_price          = "0.10"
  tcp_allowed_ingress = [ 22, 80, 443 ]
}