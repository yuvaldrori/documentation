FROM ruby:2.2.3-slim
MAINTAINER marko@codeship.com

# workdir configuration
WORKDIR /docs

# Node.js PPA
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
	apt-get update && apt-get install -y --no-install-recommends
		apt-transport-https && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

# Install required dependencies and clean up after the build.
COPY Gemfile Gemfile.lock package.json npm-shrinkwrap.json ./
RUN apt-get update && apt-get install -y --no-install-recommends \
		build-essential \
		libssl1.0.0 \
		libyaml-0-2 \
		nodejs && \
	ln -s $(which nodejs) /usr/local/bin/node && \
	echo "gem: --no-rdoc --no-ri" >> ${HOME}/.gemrc && \
  bundle install --jobs 20 --retry 5 --without development && \
  npm config set "production" "true" && \
  npm config set "loglevel" "error" && \
  npm install --global gulp && \
  npm install && \
	apt-get clean -y && \
	apt-get purge -y --auto-remove build-essential && \
	apt-get purge -y --auto-remove $(apt-mark showauto) && \
	# not sure why it gets removed by the line above and I need to reinstall it,
	# at least it doesn't add all the dependencies again!
	apt-get install -y --no-install-recommends nodejs && \
	rm -rf /usr/local/bundle/gems/*/cache/*.gem && \
  rm -rf ${HOME}/.npm/* && \
	rm -rf /var/lib/apt/lists/*

# add the source
COPY . ./
