variable "env" {
  type    = string
  default = "dev or prod"
}

variable "config" {
  type = map(any)
}
