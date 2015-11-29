require 'rails_helper'

describe Blog do
	it "成功创建一篇博客" do
		expect(build(:blog)).to be_valid
	end

	it "博客标题为空，无效" do
		blog = build(:blog, title: nil);
		blog.valid?
		expect(blog.errors[:title]).not_to include("博客标题不能为空！")
	end

	it "博客内容为空，无效" do
		blog = build(:blog, content: nil);
		blog.valid?
		expect(blog.errors[:content]).not_to include("博客内容不能为空！")
	end

	it "用户id为空，无效" do
		blog = build(:blog, user_id: nil);
		blog.valid?
		expect(blog.errors[:user_id]).not_to include("用户id不能为空！")
	end

	
end