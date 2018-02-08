#!/bin/bash

sudo apt-get update
echo 'DOCKER_OPTS="-H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock -s devicemapper"' | sudo tee /etc/default/docker > /dev/null
sudo service docker restart
sleep 5
sudo docker pull centos:centos7
