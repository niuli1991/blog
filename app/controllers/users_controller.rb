class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only:[:index]
  protect_from_forgery :except => :receive_guest
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end
  
  
end
