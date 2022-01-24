class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]
  include ActionView::RecordIdentifier

  def create
    @post.likes << Like.new(user_id: current_user.id) unless liked?
    redirect_to posts_path(@post, anchor: dom_id(@post))
  end

  def destroy
    if !(liked?)
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

  def liked?
    @post.likes.any? { |post| post.user_id == current_user.id }
  end
  
  def find_like
    @like = @post.likes.find(params[:id])
 end
end
