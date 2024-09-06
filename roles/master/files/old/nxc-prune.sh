#!/bin/bash
docker volume prune -f
docker container prune -f
docker image prune -f
