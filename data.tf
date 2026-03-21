data "aws_availability_zones" "all_vailable_zones" {
  state = "available"
  all_availability_zones = true
}