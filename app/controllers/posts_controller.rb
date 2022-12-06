class PostsController < ApplicationController
  # Actions
  def index
    @user = User.find(params[:id])
    @posts = Post.where(author_id: params(@user.id))
  end

  def show
    @post = Post.find(params[:id])
  end
end
