FROM ruby:2.5.1
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /my_child_callendar

ADD Gemfile /my_child_callendar/Gemfile
ADD Gemfile.lock /my_child_callendar/Gemfile.lock


RUN \
  gem update --system --quiet && \
  gem install  bundler -v '~> 2.1.4'

ENV BUNDLER_VERSION 2.1.4

RUN bundle install

ADD . /my_child_callendar