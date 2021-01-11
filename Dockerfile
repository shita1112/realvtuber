
FROM circleci/ruby:2.6.5-node-browsers

RUN apt-get update -qq && \
    apt-get install -y apt-utils build-essential apt-transport-https libxml2-dev  postgresql-client
#############################################################
# - Install nodejs (Rails needs a javascript runtime to be
# 	installed on the platform its running)
# - Download and install rails and bundler (correct versions)
# 	of ruby software packages
#############################################################
RUN apt-get update && apt-get install -y nodejs
RUN gem install rails
RUN gem install bundler

#############################################################
# - Make folder for the app
# - Copy the app from your OS to the docker image
# - Set the app folder as a working directory
#############################################################
RUN bundle config path /usr/local/bundle
ENV APP_ROOT /app

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

#############################################################
# - ONBUILD = command executes after the current Dockerfile
# 	build completes.
# - RUN bundle install = creates Gemfile.lock in your
# 	repository. This ensures that your Ruby application runs
#	the same third-party code on every machine.
# - rake db:create (you can replace 'rake' with 'rails')
# 		 		   = creates the database
# - rake db:migrate = runs migrations that have not run yet
# - rake db:seed = to runs the seeds task to populate the
# 		 		   database with preliminary data
#############################################################
ONBUILD RUN bundle install --jobs=4 --retry=3 --path vendor/bundle --clean
ONBUILD RUN rake db:migrate
ONBUILD RUN rake db:seed


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]