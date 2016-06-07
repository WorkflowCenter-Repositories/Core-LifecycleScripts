#!/bin/bash

set -e
image=$1
CONTAINER_ID=$2
create_image=$3

###### get base image of task container ######
   container=$(sudo docker ps -a | grep ${CONTAINER_ID})
   b=$(echo $container | cut -d ' ' -f2)
   base=$(echo "${b//:}")

tag=$(git describe --exact-match --tags $(git log -n1 --pretty='%h'))
branch=$(git rev-parse --abbrev-ref HEAD)
wf=$(basename `git rev-parse --show-toplevel`)

image=dtdwd/$base-$wf-$branch:$tag
image=${image,,}

if [[ "$(docker images -q $image 2> /dev/null)" = "" && $create_image = "True" ]]; then
 sudo docker commit -m "new ${image} image" -a "rawa" ${CONTAINER_ID} $image
fi
