#!/bin/bash

set -e
create_image=$1
block=$(ctx node name)
CONTAINER_ID=$2
BLOCK_NAME=$(ctx node properties block_name)
BLOCK_URL=$3


ctx logger info "Dowload ${block} on ${CONTAINER_ID}"

        set +e
	  Wget=$(sudo docker exec -it ${CONTAINER_ID} which wget)
        set -e
	if [[ -z ${Wget} ]]; then
         	sudo docker exec -it ${CONTAINER_ID} apt-get update
  	        sudo docker exec -it ${CONTAINER_ID} apt-get -y install wget
        fi

 

sudo docker exec -it ${CONTAINER_ID} [ ! -d tasks ] && sudo docker exec -it ${CONTAINER_ID} mkdir tasks

sudo docker exec -it ${CONTAINER_ID} [ ! -f tasks/${BLOCK_NAME} ] && sudo docker exec -it ${CONTAINER_ID} wget -O tasks/${BLOCK_NAME} ${BLOCK_URL} 

########################### image creation ###########################
ctx logger info "Creating ${image}"

   ###### get task version ######
   #path=${BLOCK_URL%/*}   
   #ver=$(echo ${path##*/})

   ###### get task name without extension ######
   #var=$(echo ${BLOCK_NAME} | cut -f 1 -d '.')
   #image=${var,,}
   source get-task-ID.sh
   task=$(func $BLOCK_URL)
   ###### get base image of task container ######
   container=$(sudo docker ps -a | grep ${CONTAINER_ID})
   b=$(echo $container | cut -d ' ' -f2)
   base=$(echo "${b//:}")

if [[ "$(docker images -q dtdwd/$base'_'$task 2> /dev/null)" = "" && $create_image = "True" ]]; then
   sudo docker commit -m "new ${image} image" -a "rawa" ${CONTAINER_ID} dtdwd/$base'_'$task
fi


