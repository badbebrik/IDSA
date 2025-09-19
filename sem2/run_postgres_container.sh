#!/bin/bash

docker run -d \
  --name postgres_sem2 \
  --hostname postgres \
  --network sem2-net \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=testdb \
  -v postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:alpine
