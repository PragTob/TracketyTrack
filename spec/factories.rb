FactoryGirl.define do

  factory :user_story do |user_story|
    user_story.name                 "A user story"
    user_story.description          "An awesome description text"
    user_story.acceptance_criteria  "It needs to fulfill the task"
    user_story.priority             3
    user_story.estimation           4
    user_story.status               "inactive"
    user_story.users                []
  end

  factory :user do |user|
    user.name                   "User"
    user.email                  "user@example.com"
    user.description            "This is the example user."
    user.password               "Trackety"
    user.password_confirmation  "Trackety"
  end

  factory :other_user, class: "user" do |user|
    user.name                   "Bob"
    user.email                  "bobbie@example.com"
    user.password               "12345678"
    user.password_confirmation  "12345678"
  end

#  factory :sign_up_user, class: "user", parent: :user do |user|
#    user.password_confirmation "toor"
#  end

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

  factory :sprint do |sprint|
    sprint.number       1
    sprint.start_date   DateTime.strptime('2001-02-03T04:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
    sprint.end_date     DateTime.strptime('2001-02-10T04:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
    sprint.velocity     25
  end

end

