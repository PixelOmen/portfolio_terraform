output "main_vpc" {
  value = aws_vpc.main_vpc
}

output "public_subnet_ids" {
  value = [
    aws_subnet.subnet_public_a.id,
    aws_subnet.subnet_public_b.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.subnet_private_a.id,
    aws_subnet.subnet_private_b.id
  ]
}
