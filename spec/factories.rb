FactoryGirl.define do

  factory :user_story do |user_story|
    user_story.name                 "A user story"
    user_story.description          "An awesome description text"
    user_story.acceptance_criteria  "It needs to fulfill the task"
    user_story.priority             3
    user_story.estimation           4
    user_story.status               "inactive"
    user_story.work_effort          0
    user_story.users                []
    user_story.requesting_feedback  false
  end

  factory :user do |user|
    user.name                   "User"
    user.email                  "user@example.com"
    user.description            "This is the example user."
    user.password               "Trackety"
    user.password_confirmation  "Trackety"
    user.accepted               true
  end

  factory :other_user, class: "user" do |user|
    user.name                   "Bob"
    user.email                  "bobbie@example.com"
    user.description            "I am different"
    user.password               "12345678"
    user.password_confirmation  "12345678"
    user.accepted               true
  end

  factory :unaccepted_user, class: "user" do |user|
    user.name                   "Steve"
    user.email                  "Ottie@example.com"
    user.password               "123456789"
    user.password_confirmation  "123456789"
    user.accepted               false
  end

  factory :create_user, class: "user" do |user|
    user.name                   "User"
    user.email                  "user@example.com"
    user.description            "This is the example user."
    user.password               "Trackety"
    user.password_confirmation  "Trackety"
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

  factory :comment do |comment|
    comment.content     "This is a nicely implemented user story."
    comment.date        DateTime.strptime('2004-10-04T04:05:06+01:00', '%Y-%m-%dT%H:%M:%S%z')
  end

  factory :project_settings do |setting|
    setting.travis_ci_repo  false
  end

end

