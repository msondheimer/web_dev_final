class CharTag < ActiveRecord::Base
	belongs_to :photo, dependent: :destroy
	belongs_to :character, dependent: :destroy
end
