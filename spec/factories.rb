FactoryGirl.define do

  factory :user_story do |user_story|
    user_story.name                 "A user story"
    user_story.description          "An awesome description text"
    user_story.acceptance_criteria  "It needs to fulfill the task"
    user_story.priority             3
    user_story.estimation           4
    user_story.status               "inactive"
  end

  factory :user do |user|
    user.name         "User"
    user.email        "user@example.com"
    user.description  "This is the example user."
  end

  factory :other_user, class: "user" do |user|
    user.name         "Bob"
    user.email        "bobbie@example.com"
  end

  factory :role do |role|
    role.name   "Standard"
  end

  factory :other_role, class: "role" do |role|
    role.name   "Special"
  end

  factory :project do |project|
    project.title           "TheProject"
    project.description     "This is a very awesome project."
    project.repository_url  "http://example.com"
  end

end

