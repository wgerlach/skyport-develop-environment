#!/bin/bash

cat <<'EOF'

====================================================================================

#get compliance tests
cd /
git clone https://github.com/common-workflow-language/common-workflow-language.git
apk add bash
pip install cwltest


# compile
cd $AWE ; CGO_ENABLED=0 go install  ./awe-submitter/

# submit
awe-submitter --shockurl=http://skyport.local:8001/shock/api/ --serverurl=http://skyport.local:8001/awe/api/  ...

====================================================================================

EOF


source /Users/wolfganggerlach/git/Skyport2/skyport2.env
export NAME=awe-submitter
export DATADIR=/Users/wolfganggerlach/awe_data
docker rm -f ${NAME} > /dev/null 2>&1
docker run -ti --network skyport2_default --name ${NAME} --add-host skyport.local:${SKYPORT_DOCKER_GATEWAY} --workdir=/go/src/github.com/MG-RAST/AWE -v ${DATADIR}:${DATADIR}  -v /Users/wolfganggerlach/gopath/src:/go/src -v /Users/wolfganggerlach/git/Skyport2/live-data/env/:/skyport2-env/:ro  mgrast/awe-submitter-testing ash
