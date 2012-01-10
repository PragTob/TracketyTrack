git merge master
RAILS_ENV=production bundle exec rake assets:precompile --trace
rspec
git add .
git commit -am "Freshly compiled assets for your heroku pleasure"
git push origin heroku_assets
git push heroku heroku_assets:master
heroku run rake db:migrate

