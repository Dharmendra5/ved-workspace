#!/bin/bash
# Export path
if [ $# -ne 1 ]
then
echo "Run script like this to install gem    ./app.sh gem_install"
echo "Run script like this to install gem    ./app.sh reconfigure_credentials"
echo "Run script like this to install gem    ./app.sh configure_db" 
echo "Run script like this to install routes ./app.sh routes_configure"
fi

input=$1
routes=$$1
if [ "$input" == "gem_install" ]
then
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"
cd /home/ubuntu/appdb
gem install --file Gemfile
fi

if [ "$input" == "configure_db" ]
then
echo "configure database"
rails db:create
echo "generating tables"
rails generate model User name:string email:string
rails db:migrate
echo "logging into rails console and create some sample user"
rails console
User.create(name: 'John Doe', email: 'john@example.com')
fi

# Configure creds
if [ "$input" == "reconfigure_credentials" ]
then
cd /home/ubuntu/appdb/config
rm -rf credentials.yml.enc
cd /home/ubuntu/appdb/
EDITOR="nano" bin/rails credentials:edit
fi

# Configure routes
if [ "$input" == "routes_configure" ]
then
mkdir -p /home/ubuntu/appdb/app/views/users
cp index.html.erb /home/ubuntu/appdb/app/views/users/
cp users_controller.rb /home/ubuntu/appdb/app/controllers/
cp routes.rb /home/ubuntu/appdb/config/routes.rb
fi