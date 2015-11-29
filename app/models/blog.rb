class Blog < ActiveRecord::Base
	belongs_to :user
#	mount_uploader :picture, PictureUpLoader
	validates :title, presence: true, length: {minimum:5}

	#根据博客标题模糊查找博客
    def self.by_letter_title(letter)
      where("title LIKE ?", "#{letter}%").order(:title)
  	end
end
