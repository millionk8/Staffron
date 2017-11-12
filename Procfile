web: bundle exec puma -C config/puma.rb -p $PORT
worker: bundle exec sidekiq -t 5
log: echo "" > log/development.log && tail -f log/development.log
release: bundle exec rake db:migrate
