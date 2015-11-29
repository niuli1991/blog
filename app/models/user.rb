class User < ActiveRecord::Base
  has_many :blogs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :picture, PictureUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validate :picture_size

  #根据用户名称模糊查找用户
  def self.by_letter_name(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end

  #根据邮件地址模糊查找用户
  def self.by_letter_email(letter)
    where("email LIKE ?", "#{letter}%").order(:email)
  end
  private
  	def picture_size
  		if picture.size > 5.megabytes
  			errors.add(:picture,"should be less than 5Mb")
  		end
  	end
end
