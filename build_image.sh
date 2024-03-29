#!/bin/bash

# set color
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

NAMESPACE="elegoev"
CONTAINERNAME="jenkinsci-docker"
NETWORKNAME="docker-net"
LOCALCLIENTCERTS="/home/vagrant/docker-certs/client"

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

# create image
echo -e "${GREEN}######################${NC}"
echo -e "${GREEN}# >>>> create image  #${NC}"
echo -e "${GREEN}######################${NC}"
docker build --rm -t $NAMESPACE/$CONTAINERNAME .

# run image
echo -e "${GREEN}######################${NC}"
echo -e "${GREEN}# >>>> run image     #${NC}"
echo -e "${GREEN}######################${NC}"
docker run -d --restart=unless-stopped --name $CONTAINERNAME \
           -p 8080:8080 -p 50000:50000 \
           -e DOCKER_TLS_CERTDIR=/certs \
           -v /var/run/docker.sock:/var/run/docker.sock \
           -v $LOCALCLIENTCERTS:/certs/client:ro \
           $NAMESPACE/$CONTAINERNAME
