web: bin/rails server -p $PORT -e $RAILS_ENV

# worker: QUEUE=heroku bundle exec rake jobs:work

# リリース時にmigrate
release: bundle exec rake db:migrate
