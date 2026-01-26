variable "region" {
  default = "ap-south-1"
}

variable "key_name" {
  description = "AWS key pair name"
}

variable "instance_type" {
  default = "t2.micro"
}
