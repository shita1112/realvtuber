web: bundle exec puma -C config/puma.rb

# worker: QUEUE=heroku bundle exec rake jobs:work

# リリース時の処理
release: bundle exec rake db:migrate && bundle exec rake sitemap:refresh