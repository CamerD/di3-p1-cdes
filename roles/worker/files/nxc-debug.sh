#!/bin/bash
docker-compose -f nextcloud.yml down
docker-compose -f traefik.yml down
sleep 1
docker-compose -f traefik.yml up -d --remove-orphans
docker-compose -f nextcloud.yml up -d
