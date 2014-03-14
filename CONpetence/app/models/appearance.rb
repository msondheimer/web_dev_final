class Appearance < ActiveRecord::Base
	belongs_to :character, dependent: :destroy
	belongs_to :franchise, dependent: :destroy
end
