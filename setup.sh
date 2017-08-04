#!/bin/bash

# install docker-engine & docker-compose
git clone https://github.com/Esfahan/installer-docker-compose.git /tmp/installer-docker-compose
bash /tmp/installer-docker-compose/setup.sh

# create keys
if [ ! -e keys ]; then
  mkdir -p keys/web keys/worker
  ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''
  ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''
  ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''
  cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
  cp ./keys/web/tsa_host_key.pub ./keys/worker
fi
