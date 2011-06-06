authorization do
  role :member do
    has_permission_on :members_members, :to => :read
    has_permission_on :members_requests, :to => [:manage, :hide]
    #This will need to be changed back to something besides manage, maybe?
    has_permission_on :members_users, :to => :manage
    has_permission_on :members_children, :to => :manage
    has_permission_on :members_profile, :to => :manage
    has_permission_on :members_neighbors, :to => :manage
    has_permission_on :members_pending_requests, :to => :manage
    has_permission_on :members_new_multiple, :to => [:new_multiple]
    has_permission_on :members_search, :to => :index
    has_permission_on :members_settings, :to => :manage
    has_permission_on :members_my_volunteers, :to => [:manage, :add_caregiver]
    has_permission_on :members_households, :to => [:create, :show, :update, :search]
  end
  role :administrator do
    includes :member
    has_permission_on :admin_admin, :to => :read
    has_permission_on :admin_users, :to => :manage
    has_permission_on :admin_roles, :to => :manage
    has_permission_on :admin_requests, :to => :manage
  end
  role :developer do
    includes :administrator
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete, :show]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => [:edit]
  privilege :delete, :includes => :destroy
  privilege :add_caregiver, :includes => :add_caregiver
  privilege :hide, :includes => [:hide_request, :hide_all_by_household]
  privilege :search, :includes => :search
end

