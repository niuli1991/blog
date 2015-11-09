class VisitorsController < ApplicationController
	protect_from_forgery :except => :receive_guest
	helper_method :current_or_guest_user	
end
