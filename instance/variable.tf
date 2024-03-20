variable "image_id" {
  type    = string
  default = "ami-0516715c2acda76a8"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_id" {
  type = string

}

variable "env" {
  type    = string
  default = "dev"
}

variable "tag" {
  type = map(string)
  default = {
    Name = "default-instance-name"
  }
}
