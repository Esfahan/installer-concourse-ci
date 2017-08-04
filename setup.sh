#!/bin/bash

# install docker-engine & docker-compose
git clone https://github.com/Esfahan/installer-docker-compose.git /tmp/installer-docker-compose
bash /tmp/installer-docker-compose/setup.sh

# create keys
if [ ! -e 'keys' ]; then
  mkdir -p keys/web keys/worker
  ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''
  ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''
  ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''
  cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
  cp ./keys/web/tsa_host_key.pub ./keys/worker
else
  echo './keys already exists. skipping...'
fi


if [ ! -e '/usr/local/bin/fly' ]; then
  curl -L https://github.com/concourse/concourse/releases/download/v3.3.4/fly_linux_amd64 > /tmp/fly
  sudo mv /tmp/fly /usr/local/bin/fly
  sudo chmod 775 /usr/local/bin/fly
else
  echo 'fly already exists. skipping...'
fi
