class PostsController < ApplicationController
  # Actions
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    new_post = current_user.posts.new(params_data)
    if new_post.save
      redirect_to user_path(id: current_user.id)
    else
      redirect_to new_user_post_path
    end
  end

  private

  def params_data
    params.require(:post).permit(:title, :text)
  end
end
