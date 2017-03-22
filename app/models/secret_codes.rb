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
end
