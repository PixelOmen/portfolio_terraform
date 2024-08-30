output "stage_vpc" {
  value = aws_vpc.stage_vpc
}

output "public_subnet_ids" {
  value = [
    aws_subnet.subnet_public_a.id,
    aws_subnet.subnet_public_b.id
  ]
}
