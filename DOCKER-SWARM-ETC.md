https://cloudaffaire.com/how-to-create-docker-swarm-cluster-in-aws-ec2/

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=us-west-1
export AWS_VPC_ID=<your_aws_vpc_id>
export AWS_AZ=<your_aws_availability_zone> #a,b,c,d,e...
export AWS_VPC_SUBNET=<your_aws_subnet_id>
 
##  Check if env variables are set
env | grep AWS*
 
#############################
##  Create a docker swarm  ##
#############################
 
##  Create the docker swarm manager node first.
docker-machine create -d amazonec2 --amazonec2-vpc-id $AWS_VPC_ID --amazonec2-region $AWS_DEFAULT_REGION --amazonec2-zone $AWS_AZ --amazonec2-instance-type t2.micro --amazonec2-subnet-id $AWS_VPC_SUBNET --amazonec2-security-group docker-swarm docker-swarm-manager
 
##  Create the two worker nodes
docker-machine create -d amazonec2 --amazonec2-vpc-id $AWS_VPC_ID --amazonec2-region $AWS_DEFAULT_REGION --amazonec2-zone $AWS_AZ --amazonec2-instance-type t2.micro --amazonec2-subnet-id $AWS_VPC_SUBNET --amazonec2-security-group docker-swarm docker-swarm-node1
docker-machine create -d amazonec2 --amazonec2-vpc-id $AWS_VPC_ID --amazonec2-region $AWS_DEFAULT_REGION --amazonec2-zone $AWS_AZ --amazonec2-instance-type t2.micro --amazonec2-subnet-id $AWS_VPC_SUBNET --amazonec2-security-group docker-swarm docker-swarm-node2
 
##  Check all the nodes
docker-machine ls


https://info.crunchydata.com/blog/an-easy-recipe-for-creating-a-postgresql-cluster-with-docker-swarm
https://github.com/CrunchyData/crunchy-containers/blob/master/examples/docker/swarm-service/docker-compose.yml
https://medium.com/@adrian.gheorghe.dev/dockerizing-your-own-personal-infrastructure-docker-swarm-rexray-traefik-lets-encrypt-7b3b29b12ad0
https://github.com/kubernetes/kompose/blob/master/docs/getting-started.md



ubuntu@aws-manager1:~$ sudo docker service ps CW-OVP_sidekiq
ID                  NAME                   IMAGE                              NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
isxkxu87h8ki        CW-OVP_sidekiq.1       [YOUR_IP]:5000/cw-ovp:latest   aws-worker1         Running             Running 21 minutes ago                       
5iixw4ztaa1p         \_ CW-OVP_sidekiq.1   [YOUR_IP]:5000/cw-ovp:latest   aws-worker2         Shutdown            Running 26 minutes ago                       
7bo7qn41qt07        CW-OVP_sidekiq.2       [YOUR_IP]:5000/cw-ovp:latest   aws-worker1         Running             Running 25 minutes ago                       
ubuntu@aws-manager1:~$ sudo docker service logs 5iixw4ztaa1p
^C
ubuntu@aws-manager1:~$ sudo docker service logs CW-OVP_sidekiq.1 
no such task or service: CW-OVP_sidekiq.1
ubuntu@aws-manager1:~$ sudo docker service logs CW-OVP_sidekiq
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:43:11.965Z pid=1 tid=goj0ke5wl INFO: Booting Sidekiq 6.1.0 with redis options {:url=>"redis://[YOUR_IP]:6379/0"}
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:43:12.449Z pid=1 tid=goj0ke5wl INFO: Booted Rails 6.0.3.2 application in development environment
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:43:12.449Z pid=1 tid=goj0ke5wl INFO: Running in ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:43:12.449Z pid=1 tid=goj0ke5wl INFO: See LICENSE and the LGPL-3.0 for licensing details.
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:43:12.449Z pid=1 tid=goj0ke5wl INFO: Upgrade to Sidekiq Pro for more features and support: https://sidekiq.org
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.754Z pid=1 tid=goj19bre5 ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.754Z pid=1 tid=goj19bre5 WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=goj19bre5 WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=goj19bn2l ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=goj19bn2l WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.756Z pid=1 tid=goj19bn2l WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.757Z pid=1 tid=goj19bnkx ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19bnkx WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19bnkx WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.757Z pid=1 tid=goj19brwh ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19brwh WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19brwh WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19brqd ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19brqd WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19brqd WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.757Z pid=1 tid=goj19bmwh ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.759Z pid=1 tid=goj19bmwh WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.759Z pid=1 tid=goj19bmwh WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19bn8p ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.759Z pid=1 tid=goj19bn8p WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.759Z pid=1 tid=goj19bn8p WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19bmqd ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.759Z pid=1 tid=goj19bmqd WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=goj19bmqd WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19bnet ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=goj19bnet WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=goj19bnet WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=goj19brk9 ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=goj19brk9 WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=goj19brk9 WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:27.584Z pid=1 tid=goj19bny9 ERROR: heartbeat: READONLY You can't write against a read only replica.
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:32.586Z pid=1 tid=goj19bny9 ERROR: heartbeat: READONLY You can't write against a read only replica.
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.855Z pid=1 tid=goj19brqd INFO: Redis is online, 10.097307309973985 sec downtime
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=goj19bmwh INFO: Redis is online, 10.098235180019401 sec downtime
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=goj19bn2l INFO: Redis is online, 10.101374662015587 sec downtime
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=goj19brk9 INFO: Redis is online, 10.097745249979198 sec downtime
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=goj19bnkx INFO: Redis is online, 10.099432853981853 sec downtime
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=goj19bnet INFO: Redis is online, 10.098240448045544 sec downtime
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=goj19brwh INFO: Redis is online, 10.099194954964332 sec downtime
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=goj19bre5 INFO: Redis is online, 10.102289832080714 sec downtime
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=goj19bn8p INFO: Redis is online, 10.098924038931727 sec downtime
CW-OVP_sidekiq.1.isxkxu87h8ki@aws-worker1    | 2020-11-12T05:48:36.857Z pid=1 tid=goj19bmqd INFO: Redis is online, 10.09885278600268 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:41:06.310Z pid=1 tid=gmo1j2zxt INFO: Booting Sidekiq 6.1.0 with redis options {:url=>"redis://[YOUR_IP]:6379/0"}
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:41:11.085Z pid=1 tid=gmo1j2zxt INFO: Booted Rails 6.0.3.2 application in development environment
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:41:11.085Z pid=1 tid=gmo1j2zxt INFO: Running in ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:41:11.085Z pid=1 tid=gmo1j2zxt INFO: See LICENSE and the LGPL-3.0 for licensing details.
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:41:11.085Z pid=1 tid=gmo1j2zxt INFO: Upgrade to Sidekiq Pro for more features and support: https://sidekiq.org
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.796Z pid=1 tid=gmo280z4p ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.797Z pid=1 tid=gmo280z4p WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.797Z pid=1 tid=gmo280z4p WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.797Z pid=1 tid=gmo280ysh ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.798Z pid=1 tid=gmo280ysh WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.798Z pid=1 tid=gmo280ysh WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.797Z pid=1 tid=gmo29afjt ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.798Z pid=1 tid=gmo29afjt WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.798Z pid=1 tid=gmo29afjt WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.797Z pid=1 tid=gmo29afpx ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.798Z pid=1 tid=gmo29afpx WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.798Z pid=1 tid=gmo29afpx WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.797Z pid=1 tid=gmo29aevd ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.798Z pid=1 tid=gmo29aevd WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.799Z pid=1 tid=gmo29aevd WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.797Z pid=1 tid=gmo280yyl ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.799Z pid=1 tid=gmo280yyl WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.796Z pid=1 tid=gmo29af7l ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.799Z pid=1 tid=gmo29af7l WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.799Z pid=1 tid=gmo29af7l WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.797Z pid=1 tid=gmo29afdp ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.799Z pid=1 tid=gmo29afdp WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.799Z pid=1 tid=gmo29afdp WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.797Z pid=1 tid=gmo29af1h ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.799Z pid=1 tid=gmo29af1h WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.800Z pid=1 tid=gmo29af1h WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.799Z pid=1 tid=gmo280yyl WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.796Z pid=1 tid=gmo29aep9 ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.800Z pid=1 tid=gmo29aep9 WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:19.800Z pid=1 tid=gmo29aep9 WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:21.133Z pid=1 tid=gmo280zi1 ERROR: heartbeat: READONLY You can't write against a read only replica.
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:26.137Z pid=1 tid=gmo280zi1 ERROR: heartbeat: READONLY You can't write against a read only replica.
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.839Z pid=1 tid=gmo29af1h INFO: Redis is online, 10.042214686982334 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.839Z pid=1 tid=gmo29afjt INFO: Redis is online, 10.042224204051308 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.839Z pid=1 tid=gmo29afdp INFO: Redis is online, 10.042198546929285 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.839Z pid=1 tid=gmo280z4p INFO: Redis is online, 10.043549182009883 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.940Z pid=1 tid=gmo29af7l INFO: Redis is online, 10.14396619994659 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.941Z pid=1 tid=gmo280ysh INFO: Redis is online, 10.144087490974925 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.941Z pid=1 tid=gmo29aevd INFO: Redis is online, 10.144315556972288 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.941Z pid=1 tid=gmo29aep9 INFO: Redis is online, 10.144745987956412 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.941Z pid=1 tid=gmo280yyl INFO: Redis is online, 10.144108427106403 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:29.941Z pid=1 tid=gmo29afpx INFO: Redis is online, 10.143284389050677 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:45.109Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO: start
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/1_00_00_03_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | frame=    1 fps=0.0 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.138x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:167kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:48.093Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/1_00_00_03_000.png /storage/22_thumbnail/1_00_00_03_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/2_00_00_08_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
frame=    1 fps=0.0 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.056x    time=00:00:00.00 bitrate=N/A speed=   0x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:191kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:49.458Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/2_00_00_08_000.png /storage/22_thumbnail/2_00_00_08_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/3_00_00_15_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
frame=    1 fps=0.9 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.0302x    ime=00:00:00.00 bitrate=N/A speed=   0x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:212kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:51.331Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/3_00_00_15_000.png /storage/22_thumbnail/3_00_00_15_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/4_00_00_16_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
frame=    1 fps=0.9 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.0284x    ime=00:00:00.00 bitrate=N/A speed=   0x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:187kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:53.284Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/4_00_00_16_000.png /storage/22_thumbnail/4_00_00_16_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/5_00_00_16_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
frame=    1 fps=0.8 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.0281x    ime=00:00:00.00 bitrate=N/A speed=   0x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:187kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:55.247Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/5_00_00_16_000.png /storage/22_thumbnail/5_00_00_16_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/6_00_00_18_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
frame=    1 fps=0.8 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.0253x    ime=00:00:00.00 bitrate=N/A speed=   0x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:194kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:57.324Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/6_00_00_18_000.png /storage/22_thumbnail/6_00_00_18_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/7_00_00_18_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
frame=    1 fps=0.8 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.0254x    ime=00:00:00.00 bitrate=N/A speed=   0x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:194kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:42:59.397Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/7_00_00_18_000.png /storage/22_thumbnail/7_00_00_18_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/8_00_00_26_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
frame=    1 fps=0.5 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.0172x    ime=00:00:00.00 bitrate=N/A speed=   0x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:260kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:43:02.285Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/8_00_00_26_000.png /storage/22_thumbnail/8_00_00_26_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/9_00_00_30_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
frame=    1 fps=0.4 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.0147x    ime=00:00:00.00 bitrate=N/A speed=   0x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:199kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:43:05.315Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/9_00_00_30_000.png /storage/22_thumbnail/9_00_00_30_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | ffmpeg version 4.1.6-1~deb10u1 Copyright (c) 2000-2020 the FFmpeg developers
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   built with gcc 8 (Debian 8.3.0-6)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   configuration: --prefix=/usr --extra-version='1~deb10u1' --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-avresample --disable-filter=resample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-shared
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavutil      56. 22.100 / 56. 22.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavcodec     58. 35.100 / 58. 35.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavformat    58. 20.100 / 58. 20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavdevice    58.  5.100 / 58.  5.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavfilter     7. 40.101 /  7. 40.101
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libavresample   4.  0.  0 /  4.  0.  0
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswscale      5.  3.100 /  5.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libswresample   3.  3.100 /  3.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   libpostproc    55.  3.100 / 55.  3.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/tmp/ActiveStorage-102-20201112-1-1895d0n.mp4':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.29.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Duration: 00:00:45.57, start: 0.000000, bitrate: 842 kb/s
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 624x444 [SAR 1:1 DAR 52:37], 705 kb/s, 30 fps, 30 tbr, 15360 tbn, 60 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:1(eng): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, stereo, fltp, 128 kb/s (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : SoundHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Stream mapping:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Stream #0:0 -> #0:0 (h264 (native) -> png (native))
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Press [q] to stop, [?] for help
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | Output #0, image2, to '/storage/22_thumbnail/10_00_00_38_000.png':
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |   Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     major_brand     : isom
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     minor_version   : 512
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     compatible_brands: isomiso2avc1mp41
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     comment         : fmoptim
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     encoder         : Lavf58.20.100
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Stream #0:0(eng): Video: png, rgb24, 506x360 [SAR 9360:9361 DAR 52:37], q=2-31, 200 kb/s, 30 fps, 30 tbn, 30 tbc (default)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |     Metadata:
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       handler_name    : VideoHandler
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    |       encoder         : Lavc58.35.100 png
frame=    1 fps=0.4 q=-0.0 Lsize=N/A time=00:00:00.03 bitrate=N/A speed=0.0122x    ime=00:00:00.00 bitrate=N/A speed=   0x    
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | video:197kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: unknown
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:43:08.763Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc INFO:  cp_thumbnail_to_cdn_cmd vod-hls 2020/11/12/22/thumbnail/10_00_00_38_000.png /storage/22_thumbnail/10_00_00_38_000.png
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:43:08.776Z pid=1 tid=gmo29afdp class=ThumbnailWorker jid=477de07d4ec15035dd8781fc elapsed=23.667 INFO: done
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.754Z pid=1 tid=gmo29afdp ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=gmo29afdp WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=gmo29afdp WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=gmo29afjt ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=gmo29afjt WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=gmo29afjt WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.754Z pid=1 tid=gmo280z4p ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=gmo280z4p WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.756Z pid=1 tid=gmo280z4p WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=gmo280ysh ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.756Z pid=1 tid=gmo280ysh WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.756Z pid=1 tid=gmo280ysh WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=gmo29af1h ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.756Z pid=1 tid=gmo29af1h WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.757Z pid=1 tid=gmo29af1h WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.755Z pid=1 tid=gmo29af7l ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.757Z pid=1 tid=gmo29af7l WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.757Z pid=1 tid=gmo29af7l WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.757Z pid=1 tid=gmo280yyl ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.757Z pid=1 tid=gmo280yyl WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.757Z pid=1 tid=gmo280yyl WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=gmo29afpx ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=gmo29afpx WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.758Z pid=1 tid=gmo29afpx WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=gmo29aep9 ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=gmo29aep9 WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=gmo29aep9 WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=gmo29aevd ERROR: Error fetching job: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=gmo29aevd WARN: Redis::CommandError: UNBLOCKED force unblock from blocking operation, instance state changed (master -> replica?)
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:26.766Z pid=1 tid=gmo29aevd WARN: /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:127:in `call'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:221:in `block in call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:295:in `with_socket_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis/client.rb:220:in `call_with_timeout'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1224:in `block in _bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `block in synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/lib/ruby/2.6.0/monitor.rb:230:in `mon_synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:69:in `synchronize'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1221:in `_bpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/redis-4.2.1/lib/redis.rb:1266:in `brpop'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `block in retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:98:in `block in redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:63:in `block (2 levels) in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:62:in `block in with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `handle_interrupt'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/connection_pool-2.2.3/lib/connection_pool.rb:59:in `with'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq.rb:95:in `redis'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/fetch.rb:39:in `retrieve_work'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:83:in `get_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:95:in `fetch'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:77:in `process_one'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | /usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:31.366Z pid=1 tid=gmo280zi1 ERROR: heartbeat: READONLY You can't write against a read only replica.
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=gmo29afjt INFO: Redis is online, 10.101205447106622 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=gmo280yyl INFO: Redis is online, 10.09892669110559 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.858Z pid=1 tid=gmo29afdp INFO: Redis is online, 10.104536039987579 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.859Z pid=1 tid=gmo29aevd INFO: Redis is online, 10.092739504994825 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=gmo29afpx INFO: Redis is online, 10.098559829988517 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=gmo29af7l INFO: Redis is online, 10.101458562072366 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.857Z pid=1 tid=gmo280ysh INFO: Redis is online, 10.101731691975147 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.859Z pid=1 tid=gmo29aep9 INFO: Redis is online, 10.092762653017417 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=gmo280z4p INFO: Redis is online, 10.102081213030033 sec downtime
CW-OVP_sidekiq.2.7bo7qn41qt07@aws-worker1    | 2020-11-12T05:48:36.856Z pid=1 tid=gmo29af1h INFO: Redis is online, 10.101761467987671 sec downtime
error from daemon in stream: Error grabbing logs: rpc error: code = Unknown desc = warning: incomplete log stream. some logs could not be retrieved for the following reasons: node ns3j1r7qgumbneet7i54ffu5n disconnected unexpectedly






2020-11-13T04:45:45.126Z pid=1 tid=grcr7pbzl class=EncodeWorker jid=820388786b0e5ae0b6041902 elapsed=1951.914 INFO: fail
2020-11-13T04:45:45.126Z pid=1 tid=grcr7pbzl WARN: {"context":"Job raised exception","job":{"retry":false,"queue":"default","backtrace":true,"class":"EncodeWorker","args":[71],"jid":"820388786b0e5ae0b6041902","created_at":1605240793.208652,"enqueued_at":1605240793.208673},"jobstr":"{\"retry\":false,\"queue\":\"default\",\"backtrace\":true,\"class\":\"EncodeWorker\",\"args\":[71],\"jid\":\"820388786b0e5ae0b6041902\",\"created_at\":1605240793.208652,\"enqueued_at\":1605240793.208673}"}
2020-11-13T04:45:45.126Z pid=1 tid=grcr7pbzl WARN: ActiveRecord::StatementInvalid: PG::ConnectionBad: PQconsumeInput() server closed the connection unexpectedly
	This probably means the server terminated abnormally
	before or while processing the request.

2020-11-13T04:45:45.126Z pid=1 tid=grcr7pbzl WARN: /usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/postgresql/database_statements.rb:92:in `exec'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/postgresql/database_statements.rb:92:in `block (2 levels) in execute'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/dependencies/interlock.rb:48:in `block in permit_concurrent_loads'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/share_lock.rb:187:in `yield_shares'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/dependencies/interlock.rb:47:in `permit_concurrent_loads'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/postgresql/database_statements.rb:91:in `block in execute'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract_adapter.rb:722:in `block (2 levels) in log'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:26:in `block (2 levels) in synchronize'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:25:in `handle_interrupt'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:25:in `block in synchronize'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:21:in `handle_interrupt'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:21:in `synchronize'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract_adapter.rb:721:in `block in log'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/notifications/instrumenter.rb:24:in `instrument'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract_adapter.rb:712:in `log'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/postgresql/database_statements.rb:90:in `execute'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/postgresql/database_statements.rb:150:in `begin_db_transaction'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/transaction.rb:179:in `materialize!'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/transaction.rb:246:in `block (2 levels) in materialize_transactions'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/transaction.rb:246:in `each'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/transaction.rb:246:in `block in materialize_transactions'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:26:in `block (2 levels) in synchronize'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:25:in `handle_interrupt'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:25:in `block in synchronize'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:21:in `handle_interrupt'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:21:in `synchronize'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/transaction.rb:243:in `materialize_transactions'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/database_statements.rb:288:in `materialize_transactions'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/postgresql_adapter.rb:666:in `exec_no_cache'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/postgresql_adapter.rb:656:in `execute_and_clear'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/postgresql/database_statements.rb:111:in `exec_delete'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/database_statements.rb:174:in `update'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/query_cache.rb:22:in `update'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/persistence.rb:385:in `_update_record'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/persistence.rb:896:in `_update_row'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/locking/optimistic.rb:79:in `_update_row'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/persistence.rb:918:in `_update_record'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/attribute_methods/dirty.rb:205:in `_update_record'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/callbacks.rb:335:in `block in _update_record'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/callbacks.rb:135:in `run_callbacks'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/callbacks.rb:825:in `_run_update_callbacks'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/callbacks.rb:335:in `_update_record'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/timestamp.rb:123:in `_update_record'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/persistence.rb:905:in `create_or_update'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/callbacks.rb:327:in `block in create_or_update'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/callbacks.rb:135:in `run_callbacks'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/callbacks.rb:825:in `_run_save_callbacks'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/callbacks.rb:327:in `create_or_update'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/timestamp.rb:128:in `create_or_update'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/persistence.rb:470:in `save'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/validations.rb:47:in `save'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/transactions.rb:314:in `block in save'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/transactions.rb:375:in `block in with_transaction_returning_status'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/database_statements.rb:278:in `transaction'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/transactions.rb:212:in `transaction'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/transactions.rb:366:in `with_transaction_returning_status'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/transactions.rb:314:in `save'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/suppressor.rb:44:in `save'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/persistence.rb:621:in `block in update'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/transactions.rb:375:in `block in with_transaction_returning_status'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/database_statements.rb:280:in `block in transaction'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/transaction.rb:280:in `block in within_new_transaction'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:26:in `block (2 levels) in synchronize'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:25:in `handle_interrupt'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:25:in `block in synchronize'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:21:in `handle_interrupt'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/concurrency/load_interlock_aware_monitor.rb:21:in `synchronize'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/transaction.rb:278:in `within_new_transaction'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/connection_adapters/abstract/database_statements.rb:280:in `transaction'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/transactions.rb:212:in `transaction'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/transactions.rb:366:in `with_transaction_returning_status'
/usr/local/bundle/ruby/2.6.0/gems/activerecord-6.0.3.2/lib/active_record/persistence.rb:619:in `update'
/myapp/app/workers/encode_worker.rb:66:in `block in perform'
/usr/local/bundle/ruby/2.6.0/gems/activestorage-6.0.3.2/lib/active_storage/downloader.rb:15:in `block in open'
/usr/local/bundle/ruby/2.6.0/gems/activestorage-6.0.3.2/lib/active_storage/downloader.rb:24:in `open_tempfile'
/usr/local/bundle/ruby/2.6.0/gems/activestorage-6.0.3.2/lib/active_storage/downloader.rb:12:in `open'
/usr/local/bundle/ruby/2.6.0/gems/activestorage-6.0.3.2/lib/active_storage/service.rb:86:in `open'
/usr/local/bundle/ruby/2.6.0/gems/activestorage-6.0.3.2/app/models/active_storage/blob.rb:219:in `open'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/core_ext/module/delegation.rb:304:in `public_send'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/core_ext/module/delegation.rb:304:in `method_missing'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/core_ext/module/delegation.rb:304:in `public_send'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/core_ext/module/delegation.rb:304:in `method_missing'
/myapp/app/workers/encode_worker.rb:9:in `perform'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:196:in `execute_job'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:164:in `block (2 levels) in process'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/middleware/chain.rb:133:in `invoke'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:163:in `block in process'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:136:in `block (6 levels) in dispatch'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/job_retry.rb:111:in `local'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:135:in `block (5 levels) in dispatch'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/rails.rb:14:in `block in call'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/execution_wrapper.rb:88:in `wrap'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/reloader.rb:72:in `block in wrap'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/execution_wrapper.rb:88:in `wrap'
/usr/local/bundle/ruby/2.6.0/gems/activesupport-6.0.3.2/lib/active_support/reloader.rb:71:in `wrap'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/rails.rb:13:in `call'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:131:in `block (4 levels) in dispatch'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:257:in `stats'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:126:in `block (3 levels) in dispatch'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/job_logger.rb:13:in `call'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:125:in `block (2 levels) in dispatch'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/job_retry.rb:78:in `global'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:124:in `block in dispatch'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/logger.rb:10:in `with'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/job_logger.rb:33:in `prepare'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:123:in `dispatch'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:162:in `process'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:78:in `process_one'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/processor.rb:68:in `run'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:15:in `watchdog'
/usr/local/bundle/ruby/2.6.0/gems/sidekiq-6.1.0/lib/sidekiq/util.rb:24:in `block in safe_thread'
