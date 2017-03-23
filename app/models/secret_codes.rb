class SecretCodes < ActiveRecord::Base
	belongs_to :user

	require "securerandom"

	COUNT_OPTIONS = [1,10,20,50,100]

	def self.create_codes count
		codes = []
		count.times.each do |i|
			code = SecureRandom.uuid[0...6] 
			codes << SecretCodes.create(code: code)
		end
		codes
  end

  def assign_user_to_security_code user_id
    self.user_id = user_id
    self.save!
  end

  scope :available,->{where("user_id is NUll")}
end
