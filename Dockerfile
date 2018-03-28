FROM ruby:2.5.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs netcat

RUN mkdir /mnt/diploma
WORKDIR /mnt/diploma
ADD Gemfile /mnt/diploma/Gemfile
Add Gemfile /mnt/diploma/Gemfile.lock
RUN gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
RUN bundle install
RUN bundle update rake
ADD . /mnt/diploma