variable "engine" {}
variable "engine_version" {}
variable "identifier" {}
variable "username" {}
variable "password" {}
variable "instance_class" {}
variable "storage_type" {}
variable "allocated_storage" {}
variable "aws_public_subnet" {}
variable "vpc_id" {}
variable "tags" {
  type = map(string)
}
variable "avaibility_zone" {}