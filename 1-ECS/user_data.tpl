#!/bin/bash
# Update all packages

sudo yum update -y
sudo yum install -y ecs-init
sudo service docker start
sudo service ecs start

#Adding cluster name in ecs config
echo "ECS_CLUSTER=ECS-TestSetup" >> /etc/ecs/ecs.config
cat /etc/ecs/ecs.config | grep "ECS_CLUSTER"