class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

#   def create
#     @user = current_user
#     @post = Post.find(params[:post_id])
#     new_comment = Comment.new(author_id: current_user.id, post_id: @post.id, text: comment_text)
#     if new_comment.save
#       redirect_to user_post_path(user_id: current_user.id, id: @post.id)
#     else
#       flash[:notice] = 'comment does not saved !'
#     end
#   end

def create
   @post = Post.find(params[:post_id])
   @user = current_user
    new_comment = current_user.comments.new(post_id: @post.id,
                                            author_id: current_user.id, text: comment_text)
    if new_comment.save
      redirect_to post_comments_path, notice: 'Success Comment Saved!'
    else
      render :new, status: 'Error occured with Comment!'
    end

  end


  def comment_text
    params.require(:comments).permit(:text)
  end
end
