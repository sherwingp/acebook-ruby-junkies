class CommentsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user
  before_action :set_post
  include ActionView::RecordIdentifier

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment posted!"
      redirect_to posts_path(@post, anchor: dom_id(@post))
    else
      flash[:alert] = 'Error posting comment!'
      redirect_to posts_path
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id
      Cloudinary::Uploader.destroy(@comment.image.key) if @comment.image.key
      @comment.update(comment_params)
    end
    if @comment.save 
      flash[:notice] = "Successful comment edit!"
      redirect_to posts_path(@comment, anchor: dom_id(@comment))
    else 
      flash[:alert] = "Error editing comment!"
      redirect_to posts_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id
      Cloudinary::Uploader.destroy(@comment.image.key) if @comment.image.key
      @comment.destroy
      flash[:notice] = "Comment deleted!"
      redirect_to posts_path(@post, anchor: dom_id(@post))
    end
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
