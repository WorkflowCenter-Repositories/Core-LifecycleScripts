#!/bin/bash

set -e

CONTAINER_NAME=$1
Lib_URL=$2
Lib_name=$(ctx node properties lib_name)
Lib_path=$(ctx node properties lib_path)

sudo docker exec -it ${CONTAINER_NAME} test -f $Lib_path/$Lib_name && exit 0
        set +e
	  Wget=$(sudo docker exec -it ${CONTAINER_NAME} which wget)
        set -e
	if [[ -z ${Wget} ]]; then
         	sudo docker exec -it ${CONTAINER_NAME} apt-get update
  	        sudo docker exec -it ${CONTAINER_NAME} apt-get -y install Wget
        fi

sudo docker exec -it ${CONTAINER_NAME} test -d $Lib_path && sudo docker exec -it ${CONTAINER_NAME} rm -rf $Lib_path

sudo docker exec -it ${CONTAINER_NAME} test ! -f $Lib_path.tar.gz && sudo docker exec -it ${CONTAINER_NAME} wget ${Lib_URL}

sudo docker exec -it ${CONTAINER_NAME} gzip -t $Lib_path.tar.gz 2>/dev/null
[[ $? -eq 0 ]] && sudo docker exec -it ${CONTAINER_NAME} tar -zxvf $Lib_path.tar.gz
