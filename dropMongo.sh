#!/bin/bash
set -e
set -x

docker exec -ti skyport2_awe-mongo_1 mongo AWEDB --eval "db.dropDatabase()"