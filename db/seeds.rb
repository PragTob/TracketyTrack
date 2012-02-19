# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# Sprint definition
sprint1 = Sprint.create( number: 1,
                         start_date: DateTime.now - 30,
                         end_date: DateTime.now - 17,
                         velocity: 25,
                         description: "Basic functionality")
sprint2 = Sprint.create( number: 2,
                         start_date: DateTime.now - 16,
                         end_date: DateTime.now - 3,
                         velocity: 25,
                         description: "Medium priority functionality")
sprint3 = Sprint.create( number: 3,
                         start_date: DateTime.now - 2,
                         velocity: 25,
                         description: "Advanced functionality")


# Project definition
project = Project.create( title: "Demo Project",
                          description: "Demo Project is a simple tool for keeping track of user stories and their status. One main feature is the support for PairProgramming.",
                          repository_url: "https://github.com/PragTob/TracketyTrack",
                          current_sprint_id: sprint3.id)

# User definition
user1 = User.create( name: "Tobi",
                     email: "pfeiffer.tobias@web.de",
                     description: "Scrum Master of the Year",
                     password: "tobi1234",
                     password_confirmation: "tobi1234")
user1.accept

user2 = User.create( name: "Basti",
                     email: "seme11@student.bth.se",
                     description: "P.O.",
                     password: "basti123",
                     password_confirmation: "basti123")
user2.accept

user3 = User.create( name: "Josi",
                     email: "josi@example.com",
                     description: "Really important part of the development team",
                     password: "josi1234",
                     password_confirmation: "josi1234")
user3.accept

user4 = User.create( name: "Flori",
                     email: "flori@example.com",
                     description: "",
                     password: "flori123",
                     password_confirmation: "flori123")
user4.accept

user5 = User.create( name: "Example User",
                     email: "user@example.com",
                     description: "Random example user",
                     password: "12345678",
                     password_confirmation: "12345678")
user5.accept

# User Story definition
  # User Stories Sprint 3
user_story1 = UserStory.create( name: "1.o Add User Story Box in Sprint Planning Mode",
                                description: "Add user story box in sprint planning mode is used to create a new user story on the sprint planning page.",
                                acceptance_criteria: "A user of the system can create a new user story on the sprint planning page.",
                                priority: 2,
                                estimation: 2,
                                status: "completed",
                                sprint_id: sprint3.id,
                                work_effort: 7200,
                                start_time: DateTime.now - 2,
                                close_time: DateTime.now - 1,
                                requesting_feedback: true)

user_story1.users << user2

user_story2 = UserStory.create( name: "1.p JavaScript Pop-Up for more Details",
                                description: "JavaScript pop-up for more details is used to show the details of a user story without leaving the current page.",
                                acceptance_criteria: "A user of the system can view all details of a user story by clicking on its name without leaving the current page.",
                                priority: 1,
                                estimation: 4,
                                status: "active",
                                sprint_id: sprint3.id,
                                start_time: DateTime.now - 2)

user_story2.users << user4

user_story3 = UserStory.create( name: "4.f Accuracy of Estimations",
                                description: "Accuracy of estimations of previous sprints can support the planning process for future sprints and reveal flaws.",
                                acceptance_criteria: "The estimated and required effort for working activities can be used to determine the accuracy of estimations.",
                                priority: 1,
                                estimation: 3,
                                status: "inactive")



  # User Stories Sprint 2
(1..5).each do |i|
  UserStory.create( name: "user story #{i}",
                    priority: Random.rand(3) + 1,
                    estimation: Random.rand(5) + 1,
                    status: "completed",
                    sprint_id: sprint2.id,
                    start_time: DateTime.now - 16 + i,
                    created_at: DateTime.now - 16 + Random.rand(5),
                    close_time: DateTime.now - 16 + 2*i)
end

  # User Stories Sprint 1
(1..5).each do |i|
  UserStory.create( name: "user story #{i + 5}",
                    priority: Random.rand(3) + 1,
                    estimation: Random.rand(5) + 1,
                    status: "completed",
                    sprint_id: sprint1.id,
                    start_time: DateTime.now - 30 + i,
                    created_at: DateTime.now - 30 + Random.rand(5),
                    close_time: DateTime.now - 30 + 2*i)
end

# Comment definition
comment1 = Comment.create( user_story_id: user_story1.id,
                           user_id: user1.id,
                           date: DateTime.now - 1,
                           content: "Looks good. Keep on going!")

