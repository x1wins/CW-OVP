# How To deploy CW-OVP on Swarm mode with Jenkins
* [Introduction](#Introduction)
* [ssh userid password in docker-machine](#ssh-userid-password-in-docker-machine)
* [deploy script](#deploy-script)

## Introduction
We need easy, fast, clean deploy in Production.
I used jenkins. i will show how to deploy with jenkins.

## ssh userid password in docker-machine
docker swarm credentials
```
user: docker
pwd: tcuser
```
- https://nozaki.me/roller/kyle/entry/articles-jenkins-sshdeploy
- https://stackoverflow.com/questions/32646952/docker-machine-boot2docker-root-password

## deploy script

```
cd /home/docker/CW-OVP
git pull
git checkout master
git reset --hard origin/master

cat <<EOT > .env.dev.s3
AWS_ACCESS_KEY_ID=[your key]
AWS_SECRET_ACCESS_KEY=[your key]
REGION=[your region] # us-west-1
BUCKET=[your bucket]
CDN_BUCKET=[your bucket]
AWS_CLOUDFRONT_DOMAIN=[your cdn domain]
EOT

# Example : docker build -t 127.0.0.1:5000/cw-ovp .
docker build -t [your registry host:port]/cw-ovp . 
docker push [your registry host:port]/cw-ovp
docker service update --image [your registry host:port]/cw-ovp CW-OVP_web
```

![jenkins-1-0.png](/screenshot/jenkins-1-0.png)
![jenkins-1-0.png](/screenshot/jenkins-1-1.png)
![jenkins-1-0.png](/screenshot/jenkins-1-2.png)
![jenkins-1-0.png](/screenshot/jenkins-1-3.png)
![jenkins-1-0.png](/screenshot/jenkins-2-1.png)
![jenkins-1-0.png](/screenshot/jenkins-2-2.png)
![jenkins-1-0.png](/screenshot/jenkins-3.png)