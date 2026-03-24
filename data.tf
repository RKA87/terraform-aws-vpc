data "aws_availability_zones" "all_available_zones" {
  state = "available"
  # all_availability_zones = true
}

data "aws_vpc" "default_vpc" {
  default = true
}