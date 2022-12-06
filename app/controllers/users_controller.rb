class UsersController < ApplicationController
  # Actions
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
