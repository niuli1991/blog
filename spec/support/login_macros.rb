module LoginMacros
	#定义辅助宏
	def set_user_session(user)
		@request.env["devise.mapping"] = Devise.mappings[user]
		sign_in :user, user
	end

	def Sign_in(user)
		visit root_path
		click_link '登录'
		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button 'Sign in'
	end

end