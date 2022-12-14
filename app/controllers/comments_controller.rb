class CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
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
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    new_comment = current_user.comments.new(comment_params)
    if new_comment.save
      redirect_to user_post_path(user_id: @user.id, id: @post.id), notice: 'Success Comment Saved!'
    else
      flash[:notice] = 'comment does not saved !'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @user = @post.author

    return unless @comment.destroy

    @post.decrement!(:comment_counter)
    redirect_to user_post_path(user_id: @user.id, id: @post.id)
  end

  private

  def comment_params
    params.permit(:text, :author_id, :post_id)
  end
end
