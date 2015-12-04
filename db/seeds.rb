# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email
User.create!(name: 'han', email: 'user@example.com', password:'hanrong', 
	password_confirmation: 'hanrong')

User.create!(name: 'hanrong', email: 'admin@example.com', password:'hanrong', 
	password_confirmation: 'hanrong', admin: true)
