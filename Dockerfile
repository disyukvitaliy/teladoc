FROM ruby:3.0.4-slim-buster

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client
RUN gem install bundler:2.4.5 && bundle config set silence_root_warning true
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install