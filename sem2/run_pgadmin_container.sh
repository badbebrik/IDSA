#!/bin/bash

docker run -d \
  --name pgadmin_sem2 \
  --network sem2-net \
  -e PGADMIN_DEFAULT_EMAIL=admin@example.com \
  -e PGADMIN_DEFAULT_PASSWORD=adminpassword \
  -v pgadmin_data:/var/lib/pgadmin \
  -p 8081:80 \
  dpage/pgadmin4:8