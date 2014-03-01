class Photo < ActiveRecord::Base

	has_attached_file :picture, 
		:storage => :s3,
		:s3_credentials => Rails.root.join("config/s3.yml"),
		:bucket => "CONpetence"
    	#:dropbox_credentials => Rails.root.join("config/dropbox.yml")
    	#, :dropbox_options => {...}
	#validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

	belongs_to :convention
	has_many :char_tags
	has_many :characters, through: :char_tags
	has_many :user_tags
	has_many :users, through: :user_tags

	def in_photo?(user_num)
		if self.users.find_by(id: user_num)
			return true
		else
			return false
		end
	end
end
