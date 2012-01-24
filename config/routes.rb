TracketyTrack::Application.routes.draw do


  resources :comments

#  put "sprints/start"
  post "sprints/stop"

  resources :sprints

  post "user_stories/start"
  post "user_stories/pause"
  post "user_stories/complete"
  post "user_stories/assign_sprint"
  post "user_stories/unassign_sprint"
  post "user_stories/resurrect"
  post "user_stories/request_feedback"
  post "user_stories/stop_requesting_feedback"
  post "user_stories/add_user"
  post "user_stories/remove_user"

  post "users/accept_user"
  post "users/reject_user"

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
  get "/deleted_list",         to: 'user_stories#deleted_list',
                              as: :deleted_list
  get"/requesting_feedback_list", to: 'user_stories#requesting_feedback_list',
                                  as: :requesting_feedback_list


  root to: "sprints#current_sprint_overview"

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

