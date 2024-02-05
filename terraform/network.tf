module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "< 5.0.0"
  name               = "vpc"
  cidr               = var.vpc_cidr
  azs                = ["ap-south-1a", "ap-south-1b"]
  private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = false
  tags = {
    Name = "skillpact-vpc"
  }
}