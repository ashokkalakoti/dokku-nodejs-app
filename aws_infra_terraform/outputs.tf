output "Ec2_public_ip" {
  value = "${aws_instance.test-dokku.public_ip}"
}

output "Ec2_private_ip" {
  value = "${aws_instance.test-dokku.private_dns}"
}