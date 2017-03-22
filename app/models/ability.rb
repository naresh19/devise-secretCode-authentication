class Ability
  include CanCan::Ability


  def initialize(user)

    puts "======================================="
    puts user.inspect
    puts user.roles.map(&:name)
    puts "======================================="

    user ||=User.new #guest user
    roles=[]

    debugger
    user.roles.each do |role|
      if (role.name ==  "admin")
        can [:manage], :all
      end
    end

  end
end
