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

# run image
echo -e "${GREEN}######################${NC}"
echo -e "${GREEN}# >>>> run sh         ${NC}"
echo -e "${GREEN}######################${NC}"
docker run -it --rm --network $NETWORKNAME \
               -e DOCKER_TLS_CERTDIR=/certs \
               -v $LOCALCLIENTCERTS:/certs/client:ro \
               docker:latest sh
