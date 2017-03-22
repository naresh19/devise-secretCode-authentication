class User < ActiveRecord::Base
	has_one :secret_code, class_name: "SecretCodes"
end
