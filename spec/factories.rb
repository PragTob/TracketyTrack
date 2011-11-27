FactoryGirl.define do

  factory :user_story do |user_story|
    user_story.name                 "A user story"
    user_story.description          "An awesome description text"
    user_story.acceptance_criteria  "It needs to fulfill the task"
    user_story.priority             3
    user_story.estimation           4
  end

  factory :user do |user|
    user.name         "User"
    user.email        "user@example.com"
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

end

