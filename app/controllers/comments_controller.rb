class CommentsController < ApplicationController

  before_action :set_user
  before_action :set_post
  include ActionView::RecordIdentifier

  def create
    @comment = @post.comments.create(comment_params)
    if @comment.save

      redirect_to posts_path(@post, anchor: dom_id(@post))
    else
      flash.now[:danger] = "error"
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
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
     params[:comment].permit(:body, :image, :user_id)
   end
end
