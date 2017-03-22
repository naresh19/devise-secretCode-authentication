class UserRoleMap < ActiveRecord::Base

  belongs_to :user, :class_name => "User"
  belongs_to :role, :class_name => "Role"

  validates_presence_of :role_id, :user_id
end
