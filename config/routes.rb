ActionController::Routing::Routes.draw do |map|
  map.resources :households
  map.resources :roles
  map.resources :requests
  map.root :controller => 'home'

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.resources :user_sessions, :only => [:new, :create, :destroy]
  map.resources :users, :only => [:new, :create]

  map.namespace :admin do |admin|
    admin.resources :roles
    admin.resources :users
    admin.resources :children
    admin.resources :households
    admin.resources :requests
    admin.root :controller => 'users'
  end

  map.namespace :members do |members|
    members.resources :roles
    members.resources :users, :only => [:show, :edit, :update]
    members.resources :children
    members.resources :households, :only => [:show, :new, :create]
    members.resources :requests, :member => {:detail => :get}
    members.resources :addresses
    members.search 'search', :controller => 'search', :action => "index"
    members.my_volunteers 'my_volunteers', :controller => 'my_volunteers', :action => "index"
    members.resources :neighbors, :member => {:confirm => :get}
    members.settings 'settings', :controller => 'settings'
    members.resources :pending_requests
    members.profile_edit 'profile/edit', :controller => 'profile', :action => 'edit'
    members.profile 'profile/', :controller => 'profile'
    members.root :controller => 'requests', :action => 'index'
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end

