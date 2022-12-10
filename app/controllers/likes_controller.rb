class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])

    new_like = current_user.likes.new(author_id: current_user.id, post_id: @post.id)
    if new_like.save
      redirect_to user_post_path(user_id: current_user.id, id: @post.id), notice: 'Success Comment Saved!'
    else
      flash[:notice] = 'comment does not saved !'
    end
  end
end
