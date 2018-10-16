#!/bin/bash

cat <<'EOF'

====================================================================================

# compile
cd $AWE ; ./compile-submitter.sh

# submit
awe-submitter --shockurl=http://skyport.local:8001/shock/api/ --serverurl=http://skyport.local:8001/awe/api/  ...

====================================================================================

EOF


source /Users/wolfganggerlach/git/Skyport2/skyport2.env
export NAME=awe-submitter
export DATADIR=/Users/wolfganggerlach/awe_data
docker rm -f ${NAME} > /dev/null 2>&1
docker run -ti --network skyport2_default --name ${NAME} --add-host skyport.local:${SKYPORT_DOCKER_GATEWAY} -e SHOCK_SERVER="http://skyport.local:8001/shock/api/" -e AWE_SERVER="http://skyport.local:8001/awe/api/" --workdir=/go/src/github.com/MG-RAST/AWE -v ${DATADIR}:${DATADIR}  -v /Users/wolfganggerlach/gopath/src:/go/src -v /Users/wolfganggerlach/git/Skyport2/live-data/env/:/skyport2-env/:ro  mgrast/awe-submitter-testing ash
