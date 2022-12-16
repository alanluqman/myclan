class PostsController < ApplicationController
  # Actions
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
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

  def destroy
    @post = Post.includes(:comments, :likes).find(params[:id])
    @user = current_user
    @post.comments.each do |comment|
      comment.destroy
    end
    @post.likes.each do |like|
      like.destroy
    end
    if @post.destroy
      @post.author.decrement!(:post_counter)
      redirect_to user_path(id: @user.id)
    end
  end

  private

  def params_data
    params.require(:post).permit(:title, :text)
  end
end
