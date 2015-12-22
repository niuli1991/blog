require 'rails_helper'

feature '普通用户' do
	scenario '增加一篇博客' do
		#@request.env["devise.mapping"] = Devise.mappings[:user]
		user = create(:user)
		Sign_in user
		visit blogs_path
		expect{
			click_link '写新文章'
			fill_in '标题', with: 'abcdefgh'
			fill_in '内容', with: '张三石头是逗比！'
			click_button '保存'
		}.to change(Blog, :count).by(1)

		#查看前面操作的结果
		#save_and_open_page
	end
end