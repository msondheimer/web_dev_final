class Photo < ActiveRecord::Base

	before_destroy :del_from_s3

	has_attached_file :picture, 
		:storage => :s3,
		:s3_credentials => Rails.root.join("config/s3_2.yml"),
		:bucket => "CONpetence"
    	#:dropbox_credentials => Rails.root.join("config/dropbox.yml")
    	#, :dropbox_options => {...}
	#validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

	belongs_to :convention
	has_many :char_tags, dependent: :destroy
	has_many :characters, through: :char_tags
	has_many :user_tags, dependent: :destroy
	has_many :users, through: :user_tags
	belongs_to :posting_user_id, foreign_key: :posting_user, class_name: "User"

	def in_photo?(user_num)
		if self.users.find_by(id: user_num)
			return true
		else
			return false
		end
	end

	def del_from_s3
		path = self.picture.url.sub("http://s3.amazonaws.com/CONpetence/","")
		creds =  YAML.load_file(Rails.root.join("config/s3_2.yml"))
		s3 = AWS::S3.new(:access_key_id => creds["access_key_id"], 
				:secret_access_key => creds['secret_access_key'])
		puts s3
		term = path.rindex("?")
		path = path[0..(term-1)]
		puts path
		obj = s3.buckets['CONpetence'].objects[path]
		puts obj
		obj.delete
		s3 = nil
		return 0
	end
end
