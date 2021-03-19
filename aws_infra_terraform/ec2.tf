data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "test-dokku" {
 ami                      = data.aws_ami.ubuntu.id
 instance_type            = "t2.micro"
 subnet_id                = "subnet-097ce800c64d29b91"
 vpc_security_group_ids   = [ "sg-06f13c8befd2f75e5" ]
 iam_instance_profile     = "SSMROLEFOREC2"
 key_name                 = "Ec2-Key"
 user_data                = "${file("install_dokku.sh")}"
 root_block_device {
   volume_size            = 10
   #volume_type           = "gp2"
   delete_on_termination  = true
 }  
  tags                    = {
    Name                  = "Test-Dokku"
  }
}


