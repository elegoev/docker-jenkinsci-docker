#!/bin/bash

# set color
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

NAMESPACE="elegoev"
CONTAINERNAME="jenkinsci-docker"

# create image
echo -e "${GREEN}#########################${NC}"
echo -e "${GREEN}# >>>> remove container #${NC}"
echo -e "${GREEN}#########################${NC}"
docker stop $CONTAINERNAME
docker rm $CONTAINERNAME

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
           $NAMESPACE/$CONTAINERNAME
