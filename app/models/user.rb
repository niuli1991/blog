class User < ActiveRecord::Base
  has_many :blogs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :picture, PictureUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validate :picture_size

  private
  	def picture_size
  		if picture.size > 5.megabytes
  			errors.add(:picture,"should be less than 5Mb")
  		end
  	end
end
