FROM ruby:2.6.3
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -qq -y build-essential nodejs yarn vim \
    libpq-dev postgresql-client ffmpeg
RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        groff \
        less \
    && pip3 install --upgrade pip \
    && apt-get clean
RUN pip3 --no-cache-dir install --upgrade awscli
RUN mkdir /myapp
RUN mkdir /storage
WORKDIR /myapp
COPY . /myapp
RUN gem update --system
RUN bundle install
RUN yarn install --check-files

ARG RAILS_MASTER_KEY
RUN if [ "$RAILS_MASTER_KEY" ] ; then RAILS_MASTER_KEY=${RAILS_MASTER_KEY} RAILS_ENV=production bundle exec rails assets:precompile ; fi

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
