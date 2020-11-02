# How To Run Docker swarm mode with docker-stack.yml
* [Introduction Scale Out with Docker Swarm](#Introduction-Scale-Out-with-Docker-Swarm)
* [Docker-machine](#Docker-machine)
    * [Docker-machine Setup on macOS](#Docker-machine-Setup-on-macOS)
    * [Docker-machine ssh](#Docker-machine-ssh)
* [Private registry](#Private-registry)
* [Initial source](#Initial-source)
* [Update source](#update-source)
* [Update s3](#update-s3)
* [Build image](#build-image)
    * [Build image and change tag with localhost:5000](#build-image-and-change-tag-with-localhost:5000)
    * [Build image with localhost:5000 for private repository](#build-image-with-localhost:5000-for-private-repository)
* [Push Image to Pirvate registry](#Push-Image-to-Pirvate-registry)
* [Run stack](#Run-stack)
* [Stop stack](#Stop-stack)
* [Changing Scale](#Changing-Scale)
* [Update latest image](#Update-latest-image)
* [Trouble shooting](#Trouble-shooting)

## Introduction Scale Out with Docker Swarm
CW-OVP can have many background job for video packaging and encoding with ffmpeg. 
You must do scale out in production environment due to you require HA and saving time.
If you want get ```scale in```, you can get it but you know ```scale in``` cost is expensive more than ```scale out```.
I provide scale out of solution with docker swarm.
I recommend 16 core for each server of ```worker node``` but mininum spec is ```4 or 8 or more core```.

## Docker-machine
If you want run on local PC or docker-machine driver with aws or digital ocean or another cloud service that support docker-machine, Do use docker-machine.
But if you don't wanna docker-machine, bypass this section go to next section of [Private registry](#Private-registry)
    
- Reference
    - sample docker-stack.yml https://github.com/dockersamples/example-voting-app/blob/master/docker-stack.yml
    - https://github.com/docker/machine

### Docker-machine Setup on macOS
```
brew install virtualbox
brew install docker-machine
docker-machine create -d virtualbox master
docker-machine create -d virtualbox worker1
docker-machine create -d virtualbox worker2
docker-machine ls
```

> if you don't have virtualbox. you got blow of message.
```
VBoxManage not found. Make sure VirtualBox is installed and VBoxManage is in the path.
```

### Docker-machine ssh
```
docker-machine ssh master
### or eval "$(docker-machine env master)"

docker@master:~$ docker swarm init --advertise-addr 192.168.99.100                                                                                                                                        

Swarm initialized: current node (4l396ni602807sb2hk1ujlvm5) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-5jcphjyj4ykejxphj2o15yh7bz4syyxo5qg8bt25ldkhd4poez-1l2skxj2931mtjolwd43139jy 192.168.99.100:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

```
docker-machine ssh worker1
   ( '>')
  /) TC (\   Core is distributed with ABSOLUTELY NO WARRANTY.
 (/-_--_-\)           www.tinycorelinux.net

docker@worker1:~$ docker swarm join --token SWMTKN-1-5jcphjyj4ykejxphj2o15yh7bz4syyxo5qg8bt25ldkhd4poez-1l2skxj2931mtjolwd43139jy 192.168.99.100:2377
This node joined a swarm as a worker.
```

```
docker-machine ssh worker2
   ( '>')
  /) TC (\   Core is distributed with ABSOLUTELY NO WARRANTY.
 (/-_--_-\)           www.tinycorelinux.net

docker@worker2:~$ docker swarm join --token SWMTKN-1-5jcphjyj4ykejxphj2o15yh7bz4syyxo5qg8bt25ldkhd4poez-1l2skxj2931mtjolwd43139jy 192.168.99.100:2377
This node joined a swarm as a worker.
```

## Private registry
- Reference
    - https://docs.docker.com/engine/swarm/stack-deploy/
```
docker-machine ssh master

docker service create --name registry --publish published=5000,target=5000 registry:2
curl http://localhost:5000/v2/
```

## Initial source
```
git clone https://github.com/x1wins/CW-OVP.git
cd ./CW-OVP
git fetch
git checkout master # or feature/docker-stack
```

## Update source 
> if you change source, use ```git pull or fetch```
```
cd CW-OVP/
git pull
git reset --hard origin/master # or origin/feature/docker-stack
```

## Update s3
```
vi .env.dev.s3
```

## Build image
- build image and change tag with localhost:5000
    ```
    docker build -t cw-ovp:latest .
    docker tag cw-ovp:latest localhost:5000/cw-ovp
    docker tag localhost:5000/cw-ovp:latest 127.0.0.1:5000/cw-ovp
    ```
- build image with localhost:5000 for private repository
    ```
    docker build -t 127.0.0.1:5000/cw-ovp . 
    ```

## Push Image to Pirvate registry
```
docker push 127.0.0.1:5000/cw-ovp
```

## Run stack
```
docker stack deploy --compose-file docker-stack.yml CW-OVP
docker exec -it 1f7193e6042e bundle exec rails webpacker:install
docker exec -it 1f7193e6042e bundle exec rake db:migrate 
```
- visual display url
    - http://192.168.99.100:8080/
- CW-OVP url
    - http://192.168.99.100:3000/

## Stop stack
```
docker stack rm CW-OVP
```

## Changing Scale
```
docker@master:~/CW-OVP$ docker service scale CW-OVP_web=1                                                                                                                                                 
CW-OVP_web scaled to 1
overall progress: 1 out of 1 tasks 
1/1: running   [==================================================>] 
verify: Service converged 
docker@master:~/CW-OVP$ docker service ls                                                                                                                                                                 
ID                  NAME                MODE                REPLICAS            IMAGE                             PORTS
jc1sqff4pyni        CW-OVP_db           replicated          1/1                 postgres:10.10                    *:5432->5432/tcp
i5mpujb9hqh5        CW-OVP_redis        replicated          1/1                 redis:latest                      *:6379->6379/tcp
7olizwz0kn9g        CW-OVP_sidekiq      replicated          2/2                 127.0.0.1:5000/cw-ovp:latest      
tyu6zey671ky        CW-OVP_visualizer   replicated          1/1                 dockersamples/visualizer:stable   *:8080->8080/tcp
mgwbtswxctjk        CW-OVP_web          replicated          1/1                 127.0.0.1:5000/cw-ovp:latest      *:3000->3000/tcp
kchi30notd2m        registry            replicated          1/1                 registry:2                        *:5000->5000/tcp
```

## Update latest image
- https://stackoverflow.com/a/61822322/1399891
```
docker service update --image 127.0.0.1:5000/cw-ovp CW-OVP_web
# docker service update --image <username>/<repo> <servicename>
```

## Trouble shooting
- https://stackoverflow.com/a/45373282/1399891
```
docker service ps --no-trunc {serviceName}
docker service ps --no-trunc t9zabkgynr8c
docker service ps --no-trunc kged4le7e3jn
mkdir /home/docker/CW-OVP/tmp/redis                                                                                                                                               
mkdir /home/docker/CW-OVP/tmp/db
```
## Swarm management UI
### Docker swarm visualizer
- https://github.com/dockersamples/docker-swarm-visualizer
```
docker service create \
  --name=viz \
  --publish=8080:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer
```
### Portainer
- https://www.portainer.io/installation/
- https://github.com/portainer/portainer
- you can connect http://192.168.99.100:9000 with web browser
```
curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml
docker stack deploy --compose-file=portainer-agent-stack.yml portainer
```
### Swarmprom
- https://github.com/stefanprodan/swarmprom
```
$ git clone https://github.com/stefanprodan/swarmprom.git
$ cd swarmprom

ADMIN_USER=admin \
ADMIN_PASSWORD=admin \
SLACK_URL=https://hooks.slack.com/services/TOKEN \
SLACK_CHANNEL=devops-alerts \
SLACK_USER=alertmanager \
docker stack deploy -c docker-compose.yml mon
```

![docker_swarm_visualizer](/docker_swarm_visualizer.png)
![docker_swarm_portainer](/docker_swarm_portainer_screenshot.png)