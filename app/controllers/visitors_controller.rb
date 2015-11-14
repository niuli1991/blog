class VisitorsController < ApplicationController
	protect_from_forgery :except => :receive_guest
	helper_method :current_or_guest_user

	def index
    	@blogs = Blog.paginate(page: params[:page],per_page:5)
  	end	
end
