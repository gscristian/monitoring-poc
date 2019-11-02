provider "aws" {
  region  = "eu-west-1"
  profile = "terraform"
}

module "vpc" {
  source = "./terraform/modules/aws/vpc"
  name = "prometheus-poc"
}

module "ec2" {
  source              = "./terraform/modules/aws/ec2/instance"
  name                = "prometheus-poc"
  vpc                 = "${module.vpc.vpc_id}"
  subnet              = "${module.vpc.subnet_az1_id}"
  system_user         = "cristian"
  github_user         = "gscristian"
  instance_type       = "t3.nano"
  tcp_allowed_ingress = [ 22, 80, 9090, 9093, 3000 ]
}

output "public_ip" {
  value = "${module.ec2.public_ip}"
}
