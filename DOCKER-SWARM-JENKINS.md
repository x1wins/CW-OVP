# How To deploy CW-OVP on Swarm mode with Jenkins
* [Introduction](#Introduction)
* [ssh userid password in docker-machine](#ssh-userid-password-in-docker-machine)
* [deploy script](#deploy-script)
* [How to configure Jenkins for build and deploy](#How-to-configure-Jenkins-for-build-and-deploy)

## Introduction
We need easy, fast, clean deploy in Production.
I used jenkins. i will show how to deploy with jenkins.

## default ssh userid password in local virtual docker-machine
docker swarm credentials
```
user: docker
pwd: tcuser
```
- https://nozaki.me/roller/kyle/entry/articles-jenkins-sshdeploy
- https://stackoverflow.com/questions/32646952/docker-machine-boot2docker-root-password

## How can i get ssh-key from docker-machine for aws ec2
```
my-pc@my-pcui-MacBookPro my-pc-OVP % docker-machine config aws-manager1
--tlsverify
--tlscacert="/Users/my-pc/.docker/machine/machines/aws-manager1/ca.pem"
--tlscert="/Users/my-pc/.docker/machine/machines/aws-manager1/cert.pem"
--tlskey="/Users/my-pc/.docker/machine/machines/aws-manager1/key.pem"
-H=tcp://[your ec2 ip]:2376

my-pc@my-pcui-MacBookPro my-pc-OVP % ssh -i /Users/my-pc/.docker/machine/machines/aws-manager1/id_rsa ubuntu@[your ec2 ip] 
Welcome to Ubuntu 16.04.4 LTS (GNU/Linux 4.4.0-1117-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

101 packages can be updated.
1 update is a security update.

New release '18.04.5 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Sun Nov 15 07:05:33 2020 from xxx.xxx.xxx.xxx
ubuntu@aws-manager1:~$ 
```

## Jenkins on docker
```
docker run \
          --name jenkins-server \
          --publish 8081:8080 \
          --publish 50000:50000 \
          --volume /var/jenkins:/var/jenkins_home \
          jenkins/jenkins:lts
```

## Jenkins run on docker swarm
```
docker volume create jenkins_home
docker service create \
       --name jenkins-master \
       --constraint 'node.role == manager' \
       --mount source=jenkins_home,target=/var/jenkins_home \
       --publish 50000:50000 \
       --publish 8080:8080 \
       --network CW-OVP_backend \
       --replicas 1 \
       jenkins/jenkins:lts
```
https://computingforgeeks.com/running-jenkins-server-in-docker-container-systemd/
https://plugins.jenkins.io/publish-over-ssh/

## Timeout setup
1. Post-build Actions
2. SSH Publishers	
3. Advanced...
4. Exec timeout (ms) -> 6000000

## Jenkins shell exec
```
	cd ./CW-OVP/
    git checkout master 
    git pull origin master # git pull origin feature/docker-machine
    git reset --hard origin/master # git reset --hard origin/feature/docker-machine

	sudo docker build -t [MANAGER_IP]:5000/cw-ovp . 
	sudo docker push [MANAGER_IP]:5000/cw-ovp

	cd ..
    sudo docker stack rm CW-OVP

    # docker-stack.yml
    cp ./CW-OVP/docker-stack.yml ./docker-stack.yml

    # s3 configuration
    cat <<EOT > .env.dev.s3
    AWS_ACCESS_KEY_ID=[your key]
    AWS_SECRET_ACCESS_KEY=[your key]
    REGION=[your region] # us-west-1
    BUCKET=[your bucket]
    CDN_BUCKET=[your bucket]
    AWS_CLOUDFRONT_DOMAIN=[your cdn domain]
    EOT
    
    # docker service update --image [MANAGER_IP]:5000/cw-ovp CW-OVP_web
	sudo docker stack deploy --compose-file docker-stack.yml CW-OVP 

	sudo docker image prune -a -f
```

## How to configure Jenkins for build and deploy
* [Install ```publish over ssh``` plugin](#Install-publish-over-ssh-plugin)
* [Input ssh connect infomation for target server](#Input-ssh-connect-infomation-for-target-server)
* [Create Freestyle project](#Create-Freestyle-project)
* [Input Your Script](#Input-Your-Script)
* [Click ```Build Now```](#Click-Build-Now)

#### Install ```publish over ssh``` plugin
![jenkins-1-0.png](/screenshot/jenkins-1-0.png)
![jenkins-1-0.png](/screenshot/jenkins-1-1.png)
![jenkins-1-0.png](/screenshot/jenkins-1-2.png)
#### Input ssh connect infomation for target server
![jenkins-1-0.png](/screenshot/jenkins-1-3.png)
#### Create Freestyle project
![jenkins-1-0.png](/screenshot/jenkins-2-1.png)
#### Input Your Script
1. Build triggers
2. Post-build Actions  
3. Send build artifacts over SSH
4. Exec command
![jenkins-1-0.png](/screenshot/jenkins-2-2.png)
#### Click ```Build Now```
![jenkins-1-0.png](/screenshot/jenkins-3.png)