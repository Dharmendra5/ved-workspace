#!/bin/bash
# Create rails db after setting database.yaml file
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"
cd /home/ubuntu/
rails new appdb -d=postgresql
rails db:create
rails generate model User name:string email:string
rails db:migrate