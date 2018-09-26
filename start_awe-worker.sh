#!/bin/bash

cat <<'EOF'

====================================================================================

cd $AWE ; CGO_ENABLED=0 go install ./awe-worker/

/go/bin/awe-worker  --name ${NAME} --data=${WORKER_DATADIR}/data --logs=${WORKER_DATADIR}/logs --workpath=${WORKER_DATADIR}/work  --serverurl=http://skyport.local:8001/awe/api/ --group=docker --supported_apps=* --auto_clean_dir=false --debuglevel=3 

====================================================================================

EOF


cd ~/gopath/src/github.com/MG-RAST/AWE

DOCKER_VERSION=$(docker --version | grep -o "[0-9]*\.[0-9]*\.[0-9a-z\.-]*")
echo "DOCKER_VERSION: ${DOCKER_VERSION}"
DOCKER_BINARY="/Users/${USER}/bin/docker-${DOCKER_VERSION}"
if [ ! -e ${DOCKER_BINARY} ] ; then
  mkdir -p /Users/${USER}/tmp/
  cd /Users/${USER}/tmp/
  curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz
  tar -xvzf docker-${DOCKER_VERSION}.tgz -C /Users/${USER}/tmp/ docker/docker
  mv docker/docker ${DOCKER_BINARY}
fi

export NAME=skyport2_awe-worker_1
export WORKER_DATADIR=/Users/wolfganggerlach/awe_data
source /Users/wolfganggerlach/git/Skyport2/skyport2.env
docker rm -f ${NAME} > /dev/null 2>&1
docker run -ti --network skyport2_default --name ${NAME} --add-host skyport.local:${SKYPORT_DOCKER_GATEWAY}  -e NAME=${NAME} -e WORKER_DATADIR=${WORKER_DATADIR} --workdir=/go/src/github.com/MG-RAST/AWE -v ${WORKER_DATADIR}:${WORKER_DATADIR} -v /Users/wolfganggerlach/git/Skyport2/live-data/env/:/skyport2-env/:ro -v ${DOCKER_BINARY}:/usr/local/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -v /Users/wolfganggerlach/gopath/src:/go/src -v /tmp:/tmp  mgrast/awe-worker ash
