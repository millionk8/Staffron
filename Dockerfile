FROM ruby:2.6.0
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    tzdata \
    libpq-dev \
    imagemagick

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install --binstubs
ADD . .
