# variable "public_subnet_ids" {
#   type        = list(string)
#   description = "List of public subnet IDs"
# }
variable "region" {
  description = "AWS Deployment region.."
  default = "us-east-1"
}