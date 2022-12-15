class UsersController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!

  # Actions
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
