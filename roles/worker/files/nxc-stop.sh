#!/bin/bash
docker-compose -f nextcloud.yml down
docker-compose -f traefik.yml down
