class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :picture, :current_password) }
  end

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        guest_user(with_retry = false).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  def is_logined
  	unless user_signed_in?
  	 	redirect_to root_url;
  	end
  end
  private

  def create_guest_user
    u = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end
end
