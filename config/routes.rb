TracketyTrack::Application.routes.draw do


  put "sprints/start"
  put "sprints/stop"

  resources :sprints

  put "user_stories/start"
  put "user_stories/pause"
  put "user_stories/complete"
  put "user_stories/assign_sprint"
  put "user_stories/unassign_sprint"

  get "/current_sprint_list", to: 'user_stories#current_sprint_list',
                              as: :current_sprint_list
  get "/completed_stories_list", to: 'user_stories#completed_stories_list',
                              as: :completed_stories_list
  get "/work_in_progress_list", to: 'user_stories#work_in_progress_list',
                              as: :work_in_progress_list
  get "/backlog_list",          to: 'user_stories#backlog_list',
                              as: :backlog_list


  root to: "page#current_sprint_overview"

  get "/current_sprint", to: 'page#current_sprint_overview',
                         as: :current_sprint
  get "/sprint_planning", to: 'page#sprint_planning',
                          as: :sprint_planning

  resources :projects

  resources :users

  resources :user_stories

  resources :sessions, only: [:new, :create, :destroy]

  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

