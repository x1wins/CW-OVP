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



