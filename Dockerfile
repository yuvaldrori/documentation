FROM alpine:latest
MAINTAINER marko@codeship.com

# Update and install base packages
RUN apk --update add \
		bash \
		build-base \
		ca-certificates \
		git \
		libffi-dev \
		ruby \
		ruby-dev && \
  rm -rf var/cache/apk/*

# workdir configuration
WORKDIR /docs

# rubygems based dependencies
COPY Gemfile Gemfile.lock ./
RUN echo "gem: --no-rdoc --no-ri" > ${HOME}/.gemrc && \
	gem install bundler && \
	bundle install --jobs 20 --retry 5 --without development

# add the source
COPY . ./
