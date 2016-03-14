require 'rails_helper'

describe Blog do
	it "成功创建一篇博客" do
		expect(build(:blog)).to be_valid
	end

	it "博客标题为空，无效" do
		blog = build(:blog, title: nil);
		blog.valid?
		expect(blog.errors[:title]).to include("can't be blank")
	end

	it "博客内容为空，无效" do
		blog = build(:blog, content: nil);
		blog.valid?
		expect(blog.errors[:content]).to include("can't be blank")
	end

	it "用户id为空，无效" do
		blog = build(:blog, user_id: nil);
		blog.valid?
		expect(blog.errors[:user_id]).to include("can't be blank")
	end

	
end