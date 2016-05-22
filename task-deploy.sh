#!/bin/bash

set -e
blueprint=$1
block=$(ctx node name)
CONTAINER_ID=$2
BLOCK_NAME=$(ctx node properties block_name)
input=$3


ctx logger info "Execute the block"
sudo docker exec -it ${CONTAINER_ID} java -jar tasks/${BLOCK_NAME} ${blueprint} ${block} ${input}
