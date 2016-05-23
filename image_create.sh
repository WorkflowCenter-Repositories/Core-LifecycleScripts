#!/bin/bash

set -e
image=$1
CONTAINER_ID=$2
create_image=$3

if [[ "$(docker images -q dtdwd/${image} 2> /dev/null)" = "" && $create_image = "True" ]]; then
 sudo docker commit -m "new ${image} image" -a "rawa" ${CONTAINER_ID} dtdwd/${image}
fi
