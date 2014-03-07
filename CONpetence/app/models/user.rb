class User < ActiveRecord::Base
	before_destroy :nilif_posted_photos

	has_secure_password
	has_many :user_tags, dependent: :destroy
	has_many :photos, through: :user_tags
	has_many :posted_photos, foreign_key: :posting_user, class_name: "Photo"

	def nilif_posted_photos
		posteds = self.posted_photos
		posteds.each do |ph|
			ph.posting_user = nil
			ph.save
		end
	end
end
