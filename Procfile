web: bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
worker: bundle exec sidekiq -e production -C config/sidekiq.yml
release: rails db:migrate
