class User < ActiveRecord::Base
	has_secure_password
	has_many :user_tags
	has_many :photos, through: :user_tags
end
