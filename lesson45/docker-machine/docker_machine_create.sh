#! /bin/env bash

docker-machine create \
	--driver amazonec2 \
	--amazonec2-region eu-central-1 \
	--amazonec2-ami ami-042ad9eec03638628 \
	--amazonec2-instance-type t2.medium \
	--amazonec2-open-port 80 \
	--amazonec2-open-port 8080 \
	--amazonec2-open-port 6443 \
tms-docker-machine
