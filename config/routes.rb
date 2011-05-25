ActionController::Routing::Routes.draw do |map|
  map.resources :children
  map.resources :households
  map.resources :roles
  map.resources :requests
  map.root :controller => 'user_sessions', :action => 'new'

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
    admin.root :controller => 'admin', :action => 'index'
  end

  map.namespace :members do |members|
    members.resources :roles
    members.resources :users, :only => [:show, :edit, :update]
    members.resources :children
    members.resources :households
    members.resources :requests
    members.root :controller => 'members', :action => 'index'
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
