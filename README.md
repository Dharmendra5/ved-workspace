# Folder structure
- `appdb`     : ROR applicatioon code
- `files`     : DB files to be copied to database machine
- `terraform` : IAC to create 2 EC2 instance
- `db.sh`     : Post database configuration
- `app.sh`    : Post application configuration


# [DB machine] Switch to postgres user and create db and user
- chmod +x /tmp/db.sh
- /tmp/db.sh
- sudo su - postgres
- createuser -s -P appdb
- createdb postgresql -O appdb

# [ROR server]
- Update `database.yaml` file
```
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: 52.66.135.195
  username: userdb
  password: ******

development:
  <<: *default
  database: userdb_development
```


