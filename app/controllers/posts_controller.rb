class PostsController < ApplicationController
  # Actions
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author]).where(author_id: @user.id)
  end

  def show
    @post = Post.includes(:author, comments: [:author]).find(params[:id])
    @user = @post.author
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
