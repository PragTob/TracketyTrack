TracketyTrack::Application.routes.draw do


#  put "sprints/start"
  put "sprints/stop"

  resources :sprints

  put "user_stories/start"
  put "user_stories/pause"
  put "user_stories/complete"
  put "user_stories/assign_sprint"
  put "user_stories/unassign_sprint"
  post "users/accept_user"

  get "accept_users", to: "users#accept", as: :accept

  get "/current_sprint_list", to: 'user_stories#current_sprint_list',
                              as: :current_sprint_list
  get "/completed_stories_list", to: 'user_stories#completed_stories_list',
                              as: :completed_stories_list
  get "/work_in_progress_list", to: 'user_stories#work_in_progress_list',
                              as: :work_in_progress_list
  get "/backlog_list",          to: 'user_stories#backlog_list',
                              as: :backlog_list
  get "/non_estimated",         to: 'user_stories#non_estimated_list',
                              as: :non_estimated_list


  root to: "page#current_sprint_overview"

  get "/current_sprint", to: 'sprints#current_sprint_overview',
                         as: :current_sprint
  get "/sprint_planning", to: 'sprints#sprint_planning',
                          as: :sprint_planning

  resources :projects

  resources :users

  resources :user_stories

  resources :sessions, only: [:new, :create, :destroy]

  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

end

