
FROM circleci/ruby:2.6.5-node-browsers

USER root
RUN apt-get update -qq && \
    apt-get install -y apt-utils build-essential apt-transport-https libxml2-dev 

RUN apt-get update && apt-get install -y nodejs
RUN gem install rails
RUN gem install bundler
RUN apt-get install -y fonts-ipafont-gothic fonts-ipafont-mincho

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

RUN yarn install --cache-folder ~/.cache/yarn
RUN bundle exec rubocop -c .rubocop.yml

# ONBUILD RUN bundle install --jobs=4 --retry=3 --path vendor/bundle --clean
ONBUILD RUN rake db:migrate
ONBUILD RUN rake db:seed
ONBUILD RUN rake db:schema:load

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]