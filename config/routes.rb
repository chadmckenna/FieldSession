ActionController::Routing::Routes.draw do |map|
  map.resources :children

  map.resources :households

  map.resources :roles

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.resources :user_sessions

  map.namespace :admin do |admin|
    admin.resources :roles
    admin.resources :users
    admin.resources :children
    admin.resources :households
    admin.resources :requests
  end

  map.namespace :members do |members|
    members.resources :roles
    members.resources :users
    members.resources :children
    members.resources :households
    members.resources :requests
  end

  map.resources :users

  map.resources :requests
  
  map.root :requests

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
