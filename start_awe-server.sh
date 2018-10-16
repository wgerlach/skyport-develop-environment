#!/bin/bash

cat <<'EOF'

====================================================================================

cd $AWE ; ./compile.sh

awe-server --logoutput=console --debuglevel=3 --hosts=awe-mongo --user=awe --password=test --api-url='http://localhost:8001/awe/api/' --site-url='http://localhost:8081/awe/' --users=demo --oauth_urls='http://auth/cgi-bin/?action=data' --oauth_bearers='oauth'  --login_url='http://localhost:8001/auth/cgi-bin/clientAWE.cgi' --title="Wolfgang's test AWE server" --max_work_failure=1 --recover

====================================================================================

EOF


docker rm -f skyport2_awe-server_1 > /dev/null 2>&1
docker run -ti --name skyport2_awe-server_1 --rm --network skyport2_default --network-alias awe-server -p 82:8081 -p 8002:8001 -v /Users/wolfganggerlach/gopath/src:/go/src mgrast/awe
