#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

TracketyTrack::Application.load_tasks

if ['test', 'development'].include? ENV["RAILS_ENV"]
  namespace :spec do
    desc "Run all acceptance specs"
    RSpec::Core::RakeTask.new(:acceptance => 'db:test:prepare') do |t|
      t.pattern = "**/*.feature"
    end
  end
  task spec: 'spec:acceptance'
end

