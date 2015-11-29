require 'rails_helper'

describe User do
	it "用户账号和密码有效" do
		expect(build(:user)).to be_valid
	end
	it "没有email地址，无效" do 
		user = build(:user, email: nil)
		user.valid?
		expect(user.errors[:email]).not_to include("不能为空！")
	end
	it "没有密码，无效" do
		user = build(:user, password: nil)
		user.valid?
		expect(user.errors[:password]).not_to include("不能为空！")
	end
	it "密码长度不够，无效" do
		user = build(:user, password: "abc")
		user.valid?
		expect(user.errors[:password]).not_to include("密码长度不够，最少7位")
	end
	it "邮箱地址格式有误，无效(缺少@即无域名)" do
		user = build(:user, email: "demoadsd.com")
		user.valid?
		expect(user.errors[:email]).not_to include("邮箱地址格式有误!")
	end
	it "邮箱地址格式有误，无效(缺少.)" do
		user = build(:user, email: "han@examplecom")
		user.valid?
		expect(user.errors[:email]).not_to include("邮箱地址格式有误!")
	end
	it "邮箱地址格式有误，无效(无@ .)" do
		user = build(:user, email: "asdadwsfsf")
		user.valid?
		expect(user.errors[:email]).not_to include("邮箱地址格式有误!")
	end
	it "邮箱地址格式有误，无效(无用户名)" do
		user = build(:user, email: "@example.com")
		user.valid?
		expect(user.errors[:email]).not_to include("邮箱地址格式有误!")
	end
	it "邮箱地址已注册，无效" do
		create(:user, email: "han@example.com")
		user = build(:user, email: "han@example.com")
		user.valid?
		expect(user.errors[:email]).not_to include("邮箱地址已注册");
	end
	describe "模糊查找" do
		before :each do
			@han = User.create(
				email: "han@example.com",
				password: "hanrong1"
			)
			@rong = User.create(
				email: "hanrong@example.com",
				password: "hanrong2"
			)
			@zhang = User.create(
				email: "zhang@example.com",
				password: "hanrong3"
			)
		end
		context "有匹配的结果" do
			it "根据邮箱地址模糊查找用户" do
				expect(User.by_letter_email("han")).to eq [@han, @rong]
			end
		end
		context "无匹配的结果" do
			it "根据邮箱地址模糊查找用户" do 
				expect(User.by_letter_email("han")).not_to include @zhang
			end
		end
	end
	
end