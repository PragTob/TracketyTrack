git merge master
RAILS_ENV=production bundle exec rake assets:precompile --trace
rspec
git push origin heroku_assets
git push heroku heroku_assets:master

