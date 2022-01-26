class CommentsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user
  before_action :set_post
  include ActionView::RecordIdentifier

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save

      redirect_to posts_path(@post, anchor: dom_id(@post))
    else
      flash.now[:danger] = 'error'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to posts_path(@comment, anchor: dom_id(@comment))
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.id == @comment.user_id
    redirect_to posts_path
  end


  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def comment_params
    params[:comment].permit(:body, :image)
  end
end
