class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
  end

  def show
    @post = Post.includes(:author, comments: [:author]).find(params[:id])
    @user = @post.author
    respond_to do |format|
      format.html
      format.json do
        if current_user.id == params[:user_id].to_i
          render json: @post.comments
        else
          render html: "You are not authorized to see someone else's data"
        end
      end
    end
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
    @post.comments.each(&:destroy)
    @post.likes.each(&:destroy)
    return unless @post.destroy

    @post.author.decrement!(:post_counter)
    redirect_to user_path(id: @user.id)
  end

  private

  def params_data
    params.require(:post).permit(:title, :text)
  end
end
