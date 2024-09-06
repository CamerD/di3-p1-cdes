#!/bin/bash
docker-compose -f traefik.yml up -d  
docker-compose -f nextcloud.yml up -d 
