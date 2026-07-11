locals {
  ssh_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}