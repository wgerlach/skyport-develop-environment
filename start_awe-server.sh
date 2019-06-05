#!/bin/bash

cat <<'EOF'

====================================================================================

cd $AWE ; ./compile.sh

awe-server --logoutput=console --debuglevel=3 --hosts=awe-mongo --api-url='http://localhost:8001/awe/api/' --site-url='http://localhost:8081/awe/' --title="test AWE server" --max_work_failure=1 --recover --max_client_failure=1000

====================================================================================

EOF


docker rm -f testing_awe-server_1 > /dev/null 2>&1
docker run -ti --name testing_awe-server_1 --rm --network testing_default --network-alias awe-server -p 82:8081 -p 8002:8001 -v /Users/wolfganggerlach/gopath/src:/go/src mgrast/awe-server
