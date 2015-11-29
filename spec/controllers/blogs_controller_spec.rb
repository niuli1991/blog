require 'rails_helper'

describe BlogsController do
	#共享用例
	shared_examples '公共方法' do
		describe 'GET #index' do
			context '模糊查找,有结果' do
				it '从一个blog数组检索' do
					one = create(:blog, title: 'Khan2rong')
					two = create(:blog, title: 'hanrong')

					get :index, letter: 'K'
					expect(assigns(:blogs)).to match_array([one,two])
				end
				
				it '渲染index模板' do
					get :index, letter: 'K'
					expect(response).to render_template :index
				end
			end

			context '无条件查找' do
				it '从一个blog数组检索' do
					one = create(:blog, title: 'han2rong')
					two = create(:blog, title: 'hanrong')
					get :index
					expect(assigns(:blogs)).to match_array([one,two])
				end

				it '渲染index模板' do
					get :index
					expect(response).to render_template :index
				end
			end
		end

		describe 'DELETE #destroy' do
			it '删除博客' do
				@blog = create(:blog)
				expect{
					delete :destroy, id: @blog
				}.to change(Blog,:count).by(-1)
			end

			it '重定向到blogs#index' do
				@blog = create(:blog)
				delete :destroy, id: @blog
				expect(response).to redirect_to blogs_url
			end
		end

		describe 'PATCH #update' do
			context '合法的属性值' do
				it 'locates the requested @blog' do
					@blog = create(:blog, title: 'abcded')
					patch :update, id: @blog, blog: attributes_for(
						:blog)
					expect(assigns(:blog)).to eq(@blog)
				end

				it '改变@blog属性值' do
					@blog = create(:blog, title: 'abcded')
					patch :update, id: @blog, blog: attributes_for(:blog)
					expect(response).to redirect_to @blog
				end
			end

			context '不合法的属性值' do
				it '不改变博客的属性值' do
					@blog = create(:blog, title: 'abcded')
					patch :update, id: @blog, blog: attributes_for(
						:blog, title: nil ,content: 'han')
					@blog.reload
					expect(@blog.content).to_not eq('han')
					expect(@blog.title).to eq('abcded')
				end

				it '重定向到edit模板' do
					@blog = create(:blog, title: 'abcded')
					patch :update, id: @blog, blog: attributes_for(
						:invalid_blog)
					expect(response).to render_template :edit
				end
			end
		end

		describe 'GET #show' do
			it 'assigns the requested blog to @blog' do
				blog = create(:blog)
				get :show, id: blog
				expect(assigns(:blog)).to eq blog
			end

			it 'renders the :show template' do
				blog = create(:blog)
				get :show, id: blog
				expect(response).to render_template :show
			end
		end
		describe 'GET #index' do
			it '新建一篇博客并放进@blogs' do
				blog = create(:blog)
				get :index
				expect(assigns(:blogs)).to match_array [blog]
			end

			it '重定向到模板' do
				get :index
				expect(response).to render_template :index
			end
		end

		it 'POST #create' do
			expect{
				post :create, blog: attributes_for(:blog)
			}.to change(Blog, :count).by(1)
		end
	end

	describe '管理员访问' do
		before :each do
			set_user_session create(:admin)
		end
	
		it_behaves_like '公共方法'

		
	end

	describe '普通用户访问' do
		before :each do
			@title = [attributes_for(:content)]
			set_user_session create(:user)
		end

		it_behaves_like '公共方法'

		describe 'GET #edit' do
			it 'assigns the requested blog to @blog' do
				blog = create(:blog)
				get :edit, id: blog
				expect(assigns(:blog)).to eq blog
			end

			it '渲染edit模板' do
				blog = create(:blog)
				get :edit, id: blog
				expect(response).to render_template :edit
			end
		end

		describe 'POST #create' do
			context '合法的属性值' do
				it '新博客保存到数据库' do
					expect{
						post :create, blog: attributes_for(:blog,
							title_attributes: @title)
					}.to change(Blog, :count).by(1)
				end

				it '渲染show页面' do
					post :create, blog: attributes_for(:blog,
						title_attributes: @title)
					expect(response).to redirect_to blog_path(assigns[:blog])
				end
			end

			context '不合法的属性值' do
				it '新博客保存到数据库失败' do
					expect{
						post :create, blog:attributes_for(
							:invalid_blog)
					}.to_not change(Blog, :count)
				end

				it '重定向到new页面' do
					post :create, blog: attributes_for(:invalid_blog)
					expect(response).to render_template :new
				end
			end
		end

	end

	describe '游客访问' do
		it 'GET #new,重定向到登陆页面' do
			get :new
			expect(response).to redirect_to new_user_session_path
		end

		it 'GET #edit,重定向到登陆页面' do
			blog = create(:blog)
			get :edit, id: blog
			expect(response).to redirect_to new_user_session_path
		end

		it 'POST #create,重定向到登陆页面' do
			post :create, id: create(:blog), blog: attributes_for(:blog)
			expect(response).to redirect_to new_user_session_path
		end

		it 'PUT #update,重定向到登陆页面' do
			put :update, id: create(:blog), blog: attributes_for(:blog)
			expect(response).to redirect_to new_user_session_path
		end

		it 'DELETE #destroy,重定向到登陆页面' do
			delete :destroy, id: create(:blog)
			expect(response).to redirect_to new_user_session_path
		end
	end

	

	

	









end