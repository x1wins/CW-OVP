https://info.crunchydata.com/blog/an-easy-recipe-for-creating-a-postgresql-cluster-with-docker-swarm
https://github.com/CrunchyData/crunchy-containers/blob/master/examples/docker/swarm-service/docker-compose.yml
https://medium.com/@adrian.gheorghe.dev/dockerizing-your-own-personal-infrastructure-docker-swarm-rexray-traefik-lets-encrypt-7b3b29b12ad0
https://github.com/kubernetes/kompose/blob/master/docs/getting-started.md



https://nozaki.me/roller/kyle/entry/articles-jenkins-sshdeploy
docker swarm credentials
user: docker
pwd: tcuser
https://stackoverflow.com/questions/32646952/docker-machine-boot2docker-root-password

```
#!/bin/sh
cd /home/docker/CW-OVP
git pull
docker build -t 127.0.0.1:5000/cw-ovp .
docker push 127.0.0.1:5000/cw-ovp
docker service update --image 127.0.0.1:5000/cw-ovp CW-OVP_web
#docker stack deploy --compose-file docker-stack.yml CW-OVP
```
