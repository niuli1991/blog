FactoryGirl.define do
	factory :user do
		sequence(:email){|n| "demo#{n}@example.com"}
		#email {Faker::Internet.email}
		password "changeme"
		password_confirmation 'changeme'
		
		factory :admin do
			admin true
		end

		factory :invalid_user do
			email nil
		end


	end
end