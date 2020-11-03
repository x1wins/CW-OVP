# How To deploy CW-OVP on Swarm mode with Jenkins
* [Introduction](#Introduction)

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
BACKUP_INTERVAL=2m
AWS_ACCESS_KEY_ID=[your key]
AWS_SECRET_ACCESS_KEY=[your key]
REGION=[your region] # us-west-1
BUCKET=[your bucket]
CDN_BUCKET=[your bucket]
AWS_CLOUDFRONT_DOMAIN=[your cdn domain]
EOT

docker build -t 127.0.0.1:5000/cw-ovp .
docker push 127.0.0.1:5000/cw-ovp
docker service update --image 127.0.0.1:5000/cw-ovp CW-OVP_web
```

![jenkins-1-0.png](/screenshot/jenkins-1-0.png)
![jenkins-1-0.png](/screenshot/jenkins-1-1.png)
![jenkins-1-0.png](/screenshot/jenkins-1-2.png)
![jenkins-1-0.png](/screenshot/jenkins-1-3.png)
![jenkins-1-0.png](/screenshot/jenkins-2-1.png)
![jenkins-1-0.png](/screenshot/jenkins-2-2.png)
![jenkins-1-0.png](/screenshot/jenkins-3.png)