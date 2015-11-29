FactoryGirl.define do
	factory :blog do
	    #sequence(:user_id){|n| "#{n}"}
	    user_id 1
		title {Faker::Book.title}
		content {Faker::Book.author}
		factory :invalid_blog do
			title nil
		end

		factory :content do
			content 'hanrong'
		end
	end
end