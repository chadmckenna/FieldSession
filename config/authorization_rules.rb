authorization do
  role :member do
    has_permission_on :members_members, :to => :read
    has_permission_on :members_requests, :to => :manage
    #This will need to be changed back to something besides manage, maybe?
    has_permission_on :members_users, :to => :manage
    has_permission_on :members_children, :to => :manage
    has_permission_on :members_profile, :to => :manage
    has_permission_on :members_households, :to => [:create, :show, :update]
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
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => [:edit]
  privilege :delete, :includes => :destroy
end

