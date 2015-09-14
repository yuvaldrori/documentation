FROM alpine:latest
MAINTAINER marko@codeship.com

# workdir configuration
WORKDIR /docs

# Install required dependencies and clean up after the build.
COPY Gemfile Gemfile.lock package.json npm-shrinkwrap.json ./
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
  echo "gem: --no-rdoc --no-ri" > ${HOME}/.gemrc && \
  gem install bundler && \
  bundle install --jobs 20 --retry 5 --without development && \
  npm config set "production" "true" && \
  npm config set "loglevel" "error" && \
  npm install --global gulp && \
  npm install && \
  apk --purge del \
    build-base \
    git \
    libffi-dev \
    ruby-dev && \
  rm -rf /var/cache/apk/* && \
  rm -rf /usr/lib/ruby/gems/*/cache/*.gem && \
  rm -rf ${HOME}/.npm/*

# add the source
COPY . ./
