variable "region" {
  type    = string
  default = "ap-southeast-1"
}


variable "tag" {
  type = map(string)
  default = {
    Name = "default-instance-name"
  }
}
