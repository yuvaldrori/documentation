FROM alpine:latest
MAINTAINER marko@codeship.com

# workdir configuration
WORKDIR /docs

# Install required dependencies and clean up after the build.
COPY Gemfile Gemfile.lock package.json ./
RUN apk --update add \
    bash \
    build-base \
    ca-certificates \
    git \
    libffi-dev \
    nodejs \
    ruby \
    ruby-dev \
    ruby-io-console \
    ruby-json && \
  gem install bundler && \
  echo "gem: --no-rdoc --no-ri" > ${HOME}/.gemrc && \
  bundle install --jobs 20 --retry 5 --without development && \
  npm install -g gulp && \
  npm install && \
  apk --purge del \
    build-base \
    git \
    libffi-dev \
    ruby-dev && \
  rm -rf var/cache/apk/* && \
  rm -rf /usr/lib/ruby/gems/*/cache/*.gem

# add the source
COPY . ./
