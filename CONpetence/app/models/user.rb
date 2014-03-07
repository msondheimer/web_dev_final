class User < ActiveRecord::Base
	attr_accessible :email, :name, :password, :password_confirmation, :password_digest
	validates :name, presence: true#, message: "You need to enter the name."
	validates :email, presence: true
	validates :email, uniqueness: true
	validates :password, presence: true
	#validates :has_secure_password, presence: true
	has_secure_password

	before_destroy :nilif_posted_photos

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
