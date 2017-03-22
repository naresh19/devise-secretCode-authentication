class Role < ActiveRecord::Base
  has_many :user_role_maps, :class_name => "UserRoleMap"
  has_many :users, :class_name => "User", :through => :user_role_maps

end
