output "aws_public_subnet" {
  value = aws_subnet.simanis-subnet-public.*.id
}

output "vpc_id" {
  value = aws_vpc.simanis-vpc.id
}