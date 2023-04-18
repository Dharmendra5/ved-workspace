 FROM ruby:3.0.2
  RUN apt-get update && apt-get install -y nodejs
  WORKDIR /app
  COPY /app/Gemfile* .
  RUN bundle install
  COPY /app .
  COPY /files/index.html.erb /app/views/users/
  COPY /files/users_controller.rb /app/controllers/
  COPY /files/routes.rb /app/config/routes.rb
  EXPOSE 3000
  CMD ["rails", "server", "-b", "0.0.0.0"]