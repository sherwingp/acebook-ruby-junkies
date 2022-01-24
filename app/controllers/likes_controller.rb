class LikesController < ApplicationController
  before_action :find_post
  before_action :find_comment
  include ActionView::RecordIdentifier

  def create
    if params.key?("comment_id")
      @comment.likes << Like.new(user_id: current_user.id) unless liked?(@comment)
    else
      @post.likes << Like.new(user_id: current_user.id) unless liked?(@post)
    end
    redirect_to posts_path(@post, anchor: dom_id(@post))
  end

  def destroy
    params.key?("comment_id") ? @likeable = @comment : @likeable = @post
    @like = find_like(@likeable)
    if !(liked?(@likeable))
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to posts_path(@post, anchor: dom_id(@post))
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:comment_id])
  end

  def liked?(likeable)
    likeable.likes.any? { |post| post.user_id == current_user.id }
  end
  
  def find_like(likeable)
    @like = likeable.likes.find(params[:id])
 end
end
