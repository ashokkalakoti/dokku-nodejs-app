# Dokku-NodeJs-Sample-App
### Deployment of a Node.js project on AWS EC2 instance
##### This is just a static website hosting using NodeJs with express framework - images are hyperlinked.

### Update the Ec2 instance - Run the below commands as a root user 
```
apt-get update -y
```
### Bootstrap the node first - Run the following commands
#### for debian systems, installs dokku via apt-get

```
  wget https://raw.githubusercontent.com/dokku/dokku/v0.23.5/bootstrap.sh

  sudo DOKKU_TAG=v0.23.5 bash bootstrap.sh
```
### Now login to the server and create a dokku app
```
dokku apps:create nodejs-sample-app

```

#### Once app is created verify the app created status by running the below command
```
 dokku apps:list
 ```
 
## Next enable the SSH key-based authentication from the development machine to make connectivity via hostname(Eg: dokku) and username and private key

vim ~/.ssh/config
```
Host dokku
    HostName 54.xx.xx.xxx
    User ubuntu
    Port 22
    IdentityFile /dxx/xx/xxx-Key.pem
```
### Run the below command from the source code directory. This will add the remote repository  
```
 git remote add dokku dokku@dokku:nodejs-sample-app

```
Notes: 
 #### First `dokku` - is the git remote name
 #### Second `dokku` is the linux user for application life cycle maintenence
 #### `@dokku` - is the server name - where you've configured in ssh/config
 #### `nodejs-sample-app` - is your dokku application name which created in the above step
 
### Deploy the app
 ```
 git add .
 git commit -am "adding nodejs application to dokku"
 git push dokku master
 ```
 ``
=====> Application deployed:
To dokku:nodejs-sample-app
   8f923f2..e344afb  master -> master
   
``
### Map the DNS record to point to your EC2 instance static Public IP or Application Loadbalancer DNS

`eg: hello-world is pointing to my EC2 public IP`

### test the application by click the registered FQDN:
   @ https://hello-world.cloudreinforce.com/


#### All the bove manual steps to deploy the application is fully automated with Gitlab CI tool. (deployment steps are placed in .gitlab-ci.yml). The gitlab project required few variables like 
1. `SSH_PRIVATE_KEY`   --> Private key file which required to connect AWS EC2 instance
2. `DOKKU_SERVER_IP`   --> EC2 public IP (if gitlab is hosted solution)/ EC2 private IP (if gitlab running in private network like within the VPC) 


## Todo:

1. #### We could improve this Nodejs sample app architecture and security by adding ALB/CloudFront infront of EC2. This helps to migigate the Public IP expose directly.

(or)

2. #### To run this application in a most production grade manner using AWS ECS fargate or EKS - These solutions helps with least admin overhead, high availability and Cost optimization.

3. #### Fully automated CICD pipeline can be possible with AWS DevOps tools like Codecommit, codebuild, codepipeline and Codedeploy.
