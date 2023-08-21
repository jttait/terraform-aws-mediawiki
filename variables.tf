variable "mariadb_password" {
  description = "This is password for the MariaDB user wikiuser"
  type        = string
  sensitive   = true
}

variable "ssh_key_pair_name" {
	description = "This is name of the SSH key pair for EC2 instance (don't include .pem)"
	type = string
}