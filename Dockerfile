FROM ruby:2.2
MAINTAINER marko@codeship.com

# OS dependencies
RUN apt-get update && apt-get install -y \
	git \
	locales

# locale settings
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# workdir configuration
WORKDIR /docs

# rubygems based dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && \
	bundle install --jobs 20 --retry 5 --without development

# add the source
COPY . ./
