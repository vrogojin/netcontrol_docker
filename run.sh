#!/bin/bash
# Script to run the latest experimental version of NetControl4BioMed pipeline

#docker-compose down --remove-orphans
#docker-compose rm
docker-compose stop
git pull
docker-compose build
docker-compose up --force-recreate
