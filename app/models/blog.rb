class Blog < ActiveRecord::Base
	belongs_to :user
#	mount_uploader :picture, PictureUpLoader
	validates :title, presence: true, length: {minimum:5}
end
