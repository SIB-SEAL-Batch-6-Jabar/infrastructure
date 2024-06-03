variable "vpc_cidr" {}
variable "public_sn_count" {}
variable "public_cidrs" {
  type = list(any)
}
variable "tags" {
  type = map(string)
}
variable "rt_route_cidr_block" {}
variable "map_public_ip_on_launch" {}
variable "avaibility_zone" {
  
}