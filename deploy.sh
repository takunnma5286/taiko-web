#!/bin/bash

docker run --detach \
  --name taiko-mongo \
  --volume taiko-mongo:/data/db \
  mongo

docker run --detach \
  --name taiko-redis \
  --volume taiko-redis:/data \
  redis

docker run --detach \
  --name taiko \
  --link taiko-mongo \
  --link taiko-redis \
  --env TAIKO_WEB_MONGO_HOST=taiko-mongo \
  --env TAIKO_WEB_REDIS_HOST=taiko-redis \
  --env LETSENCRYPT_HOST=taikoapp.uk \
  --env VIRTUAL_HOST=taikoapp.uk \
  --env VIRTUAL_PORT=8080 \
  --publish 9999:8080 \
  taiko
