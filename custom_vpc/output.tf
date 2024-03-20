output "vpc_id" {
  value = aws_vpc.g1-vpc-01.id
}

output "pub_sub_01_id" {
  value = aws_subnet.g1-pub-sub-01.id
}

output "pri_dev_sub_01_id" {
  value = aws_subnet.g1-pri-dev-sub-01.id
}

output "pri_dev_sub_02_id" {
  value = aws_subnet.g1-pri-dev-sub-02.id
}

output "pri_db_sub_01_id" {
  value = aws_subnet.g1-pri-db-sub-01.id
}
