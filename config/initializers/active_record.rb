class ActiveRecord::Base

  before_save :set_updated_by
  before_create :set_created_by
  before_update :set_updated_by
  belongs_to :creator, class_name: 'User', foreign_key: :created_by, primary_key: 'id'
  belongs_to :last_updated_by, class_name: 'User', foreign_key: :updated_by, primary_key: 'id'


  def set_updated_by
    if User.current_user.present?
      debugger
      user = User.current_user
      puts "==================================="
      user.inspect
      puts "==================================="
      self.created_by = user.id if self.has_attribute?(:created_by)
    end
  end

  def set_created_by
    if User.current_user.present?
      user= User.current_user
      self.created_by = user.id if self.has_attribute?(:created_by)
    end
  end

end
