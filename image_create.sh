#!/bin/bash

set -e
image=$1
CONTAINER_ID=$2
create_image=$3

###### get base image of task container ######
   container=$(sudo docker ps -a | grep ${CONTAINER_ID})
   b=$(echo $container | cut -d ' ' -f2)
   base=$(echo "${b//:}")

if [[ "$(docker images -q dtdwd/$base-${image} 2> /dev/null)" = "" && $create-image = "True" ]]; then
 sudo docker commit -m "new ${image} image" -a "rawa" ${CONTAINER_ID} dtdwd/$base-${image}
fi
