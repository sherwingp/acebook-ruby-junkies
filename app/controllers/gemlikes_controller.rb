class GemlikesController < ApplicationController
  before_action :find_post
  include ActionView::RecordIdentifier

  def create
    find_comment if params.key?("comment_id")
    if params.key?("comment_id")
      @comment.gemlikes << Gemlike.new(user_id: current_user.id) unless gemliked?(@comment)
    else
      @post.gemlikes << Gemlike.new(user_id: current_user.id) unless gemliked?(@post)
    end
    redirect_to posts_path(@post, anchor: dom_id(@post))
  end

  def destroy
    find_comment if params.key?("comment_id")
    params.key?("comment_id") ? @gemlikeable = @comment : @gemlikeable = @post
    @gemlike = find_gemlike(@gemlikeable)
    if !(gemliked?(@gemlikeable))
      flash[:notice] = "Cannot ungemlike"
    else
      @gemlike.destroy
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

  def gemliked?(gemlikeable)
    gemlikeable.gemlikes.any? { |post| post.user_id == current_user.id }
  end
  
  def find_gemlike(gemlikeable)
    @gemlike = gemlikeable.gemlikes.find(params[:id])
 end
end