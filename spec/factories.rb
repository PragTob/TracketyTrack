#require 'factory_girl_rails'

Factory.define :user_story do |user_story|
  user_story.name                 "A user story"
  user_story.description          "An awesome description text"
  user_story.acceptance_criteria  "It needs to fulfill the task"
  user_story.priority             3
  user_story.estimation           4
end

Factory.define :user do |user|
  user.name         "User"
  user.email        "user@example.com"
  user.description  ""
end
