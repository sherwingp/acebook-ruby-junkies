class LikesController < ApplicationController
  include ActionView::RecordIdentifier
  
  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user_id: current_user.id)
    redirect_to posts_path(@post, anchor: dom_id(@post))
    # anchor: ‘some_anchor’
  end
end

# post /posts/:id/like