#!/bin/bash

# set color
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

CONTAINERNAME="mydocker"
CONTAINERIMAGE="docker:dind"
NETWORKNAME="docker-net"
LOCALCACERTS="/home/vagrant/docker-certs/ca"
LOCALCLIENTCERTS="/home/vagrant/docker-certs/client"

# create network
echo -e "${GREEN}#########################${NC}"
echo -e "${GREEN}# >>>> create network    ${NC}"
echo -e "${GREEN}#########################${NC}"
NETWORKID=$(docker network ls | grep $NETWORKNAME | awk '{ print $1 }')
if [ -z $NETWORKID ]
then
  docker network create --driver bridge $NETWORKNAME
  echo -e "Network $NETWORKNAME created"
else
  echo -e "Network $NETWORKNAME already exists"
fi

# delete image
echo -e "${GREEN}#########################${NC}"
echo -e "${GREEN}# >>>> remove container  ${NC}"
echo -e "${GREEN}#########################${NC}"
CONTAINERID=$(docker ps -a | grep $CONTAINERNAME | awk '{ print $1 }')
if [ -z $CONTAINERID ]
then
  echo -e "Container $CONTAINERNAME doesn't exists"
else
  docker stop $CONTAINERNAME
  docker rm $CONTAINERNAME
  echo -e "Container $CONTAINERNAME deleted"
fi

# run image
echo -e "${GREEN}######################${NC}"
echo -e "${GREEN}# >>>> run image      ${NC}"
echo -e "${GREEN}######################${NC}"
# -v /var/run/docker.sock:/var/run/docker.sock \
docker run --privileged --name $CONTAINERNAME -d \
           --network $NETWORKNAME --network-alias docker \
           -e DOCKER_TLS_CERTDIR=/certs \
           -v $LOCALCACERTS:/certs/ca \
           -v $LOCALCLIENTCERTS:/certs/client \
           $CONTAINERIMAGE
