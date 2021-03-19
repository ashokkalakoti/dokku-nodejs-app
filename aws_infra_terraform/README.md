## This terraform code is to create a EC2 instance within the existing VPC 

### It required few inputs like subnet id, security group, Key pair name and IAM role name

### The provider file doesnot contain any credential, hence you must configure the AWS CLI from where the terraform commands are executing

### The AMI id will be fetched dynamically based on the AWS region

### The Ec2 instance has configured with the userdata  to bootstrap the dokku platform and application

### Refer the below script which included as part of the Ec2 userdata

```
#!/bin/bash
sudo apt-get update -y
sleep 10
sudo wget https://raw.githubusercontent.com/dokku/dokku/v0.23.5/bootstrap.sh
sleep 10
sudo DOKKU_TAG=v0.23.5 bash bootstrap.sh
sleep 10
dokku apps:create hello-world
sudo su -
cat /home/ubuntu/.ssh/authorized_keys >> /home/dokku/.ssh/authorized_keys

```

### Once the EC2 has been provisioned, it will give the output of Ec2 public IP which you have to configure with your Gitlab cicd to deploy this application